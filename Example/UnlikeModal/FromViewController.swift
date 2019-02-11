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

    var interactor: UnlikeModalInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = UnlikeModalInteractor(ModalAnimator(type: .scaleUp, duration: 1.0))
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTap() {
        let toVC = ToViewController()
        toVC.transitioningDelegate = interactor
        present(toVC, animated: true, completion: nil)
    }
}
