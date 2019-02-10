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
}

public class ModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval = 0.0
    var originFrame: CGRect = .zero
    private var animate: ((UIViewControllerContextTransitioning) -> Void)?
    
    public init?(type: AnimatorType, duration: TimeInterval = 0.0) {
        super.init()
        
        switch type {
        case .default:
            return nil
        case .fadeIn:
            self.duration = duration
            animate = fadeInAnimation
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
}
