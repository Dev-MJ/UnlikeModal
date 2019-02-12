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

    var interactor: UnlikeModalInteractor = {
        let transition = ModalAnimator(type: .scale, duration: 1.0)
        return UnlikeModalInteractor(transition)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(tap:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTap(tap: UITapGestureRecognizer) {
        let toVC = ToViewController()
        let tapPoint = tap.location(in: view)
        interactor.transition?.originFrame = CGRect(origin: tapPoint, size: CGSize(width: 10, height: 10))
        toVC.transitioningDelegate = interactor
        present(toVC, animated: true, completion: nil)
    }
}
