//
//  UnlikeModalTransitioningDelegate.swift
//  Pods-UnlikeModal_Example
//
//  Created by Dev.MJ on 11/02/2019.
//

import UIKit

public class UnlikeModalInteractor: NSObject, UIViewControllerTransitioningDelegate {
    
    private var transition: ModalAnimator?
    
    public init(_ transition: ModalAnimator?) {
        self.transition = transition
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition?.originFrame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transition?.isPresenting = true
        return transition
    }
}
