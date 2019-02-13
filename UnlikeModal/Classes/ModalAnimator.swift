//
//  PopAnimator.swift
//  UnlikeModal_Example
//
//  Created by Dev.MJ on 10/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public enum AnimatorType {
    case `default`
    case fade
    case scale
}

public enum TransitionState {
    case presenting
    case dismissing
    case none
}

public class ModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Default Properites
    private var duration: TimeInterval = 0.0
    private var animate: ((UIViewControllerContextTransitioning) -> Void)?
    // MARK: -
    var status: TransitionState = .none
    var originFrame: CGRect = .zero
    
    public init?(type: AnimatorType, duration: TimeInterval = 0.0) {
        super.init()
        
        switch type {
        case .default:
            return nil
        case .fade:
            self.duration = duration
            animate = fadeAnimation
            break
        case .scale:
            self.duration = duration
            animate = scaleAnimation
            break
        }
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animate?(transitionContext)
    }
}

// MARK: - Animation
extension ModalAnimator {
    
    private func fadeAnimation(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard
            let toView = context.view(forKey: .to),
            let fromView = context.view(forKey: .from),
            status != .none
        else { return }
        
        let animatedView = (status == .presenting) ? toView : fromView
        let defaultAlpha: CGFloat = (status == .presenting) ? 0 : 1
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: animatedView)
        
        animatedView.alpha = defaultAlpha
        UIView.animate(withDuration: duration,
                       animations: {
                        animatedView.alpha = abs(defaultAlpha - 1)
        }) { didComplete in
            context.completeTransition(didComplete)
        }
    }
    
    private func scaleAnimation(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard
            let toView = context.view(forKey: .to),
            let fromView = context.view(forKey: .from),
            status != .none
        else { return }
        
        let animatedView = (status == .presenting) ? toView : fromView
        let initialFrame = (status == .presenting) ? originFrame : animatedView.frame
        let finalFrame = (status == .presenting) ? animatedView.frame : originFrame
        
        let xScale = (status == .presenting) ? (initialFrame.width / finalFrame.width) : (finalFrame.width / initialFrame.width)
        let yScale = (status == .presenting) ? (initialFrame.height / finalFrame.height) : (finalFrame.height / initialFrame.height)
        
        let scaleTransform = CGAffineTransform(scaleX: xScale, y: yScale)
        if (status == .presenting) {
            animatedView.transform = scaleTransform
            animatedView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            animatedView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: animatedView)
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       animations: {
                        animatedView.transform = (self.status == .presenting) ? .identity : scaleTransform
                        animatedView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { didComplete in
            context.completeTransition(didComplete)
        }
    }
}
