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
    case fadeIn
    case scaleUp
}

public class ModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Default Properites
    private var duration: TimeInterval = 0.0
    private var animate: ((UIViewControllerContextTransitioning) -> Void)?
    // MARK: -
    var isPresenting: Bool = false
    var originFrame: CGRect = .zero
    
    public init?(type: AnimatorType, duration: TimeInterval = 0.0) {
        super.init()
        
        switch type {
        case .default:
            return nil
        case .fadeIn:
            self.duration = duration
            animate = fadeInAnimation
            break
        case .scaleUp:
            self.duration = duration
            animate = scaleUpAnimation
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
    
    private func fadeInAnimation(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard
            let toView = context.view(forKey: .to),
            let fromView = context.view(forKey: .from)
        else { return }
        
        containerView.addSubview(toView)
        toView.alpha = 0
        UIView.animate(withDuration: duration,
                       animations: {
                        toView.alpha = 1.0
        }) { _ in
            context.completeTransition(true)
        }
    }
    
    private func scaleUpAnimation(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard
            let toView = context.view(forKey: .to),
            let fromView = context.view(forKey: .from)
        else { return }
        
        let herbView = isPresenting ? toView : fromView
        let initialFrame = isPresenting ? originFrame : herbView.frame
        let finalFrame = isPresenting ? herbView.frame : originFrame
        
        let xScale = isPresenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        
        let yScale = isPresenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScale, y: yScale)
        if isPresenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)
        UIView.animate(withDuration: duration, animations: {
            herbView.transform = self.isPresenting ?
                CGAffineTransform.identity : scaleTransform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        },
                       completion: { _ in
                        context.completeTransition(true)
        })
    }
}
