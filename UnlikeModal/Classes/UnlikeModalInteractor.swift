//
//  UnlikeModalTransitioningDelegate.swift
//  Pods-UnlikeModal_Example
//
//  Created by Dev.MJ on 11/02/2019.
//

import UIKit

public class UnlikeModalInteractor: NSObject, UIViewControllerTransitioningDelegate {
    
    var transition: ModalAnimator?
    
    public init(_ transition: ModalAnimator?) {
        self.transition = transition
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition?.isPresenting = true
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition?.isPresenting = false
        return transition
    }
}
