//
//  FromViewController.swift
//  UnlikeModal
//
//  Created by Dev-MJ on 02/10/2019.
//  Copyright (c) 2019 Dev-MJ. All rights reserved.
//

import UIKit
import UnlikeModal

class FromViewController: UIViewController {

    let transition = ModalAnimator(type: .fadeIn, duration: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTap() {
        let toVC = ToViewController()
        toVC.transitioningDelegate = self
        present(toVC, animated: true, completion: nil)
    }
}

extension FromViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
