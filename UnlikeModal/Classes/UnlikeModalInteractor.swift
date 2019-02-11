//
//  UnlikeModalTransitioningDelegate.swift
//  Pods-UnlikeModal_Example
//
//  Created by Dev.MJ on 11/02/2019.
//

import UIKit

public class UnlikeModalInteractor: NSObject, UIViewControllerTransitioningDelegate {
    
    private var transition: UIViewControllerAnimatedTransitioning?
    
    public init(_ transition: UIViewControllerAnimatedTransitioning?) {
        self.transition = transition
    }
    
    private func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
