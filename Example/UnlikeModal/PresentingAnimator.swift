//
//  PopAnimator.swift
//  UnlikeModal_Example
//
//  Created by Dev.MJ on 10/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

enum AnimatorType {
    case `default`
    case fadeIn
}

class PresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval = 0.0
    var originFrame: CGRect = .zero
    private var animate: ((UIViewControllerContextTransitioning) -> Void)?
    
    init?(type: AnimatorType, duration: TimeInterval = 0.0) {
        super.init()
        
        switch type {
        case .default:
            return nil
        case .fadeIn:
            self.duration = duration
            animate = { [weak self] transitionContext in
                let containerView = transitionContext.containerView
                guard
                    let `self` = self,
                    let toView = transitionContext.view(forKey: .to),
                    let fromView = transitionContext.view(forKey: .from)
                    else { return }
                
                containerView.addSubview(toView)
                toView.alpha = 0
                UIView.animate(withDuration: self.duration,
                               animations: {
                                toView.alpha = 1.0
                }) { _ in
                    transitionContext.completeTransition(true)
                }
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animate?(transitionContext)
    }
}
