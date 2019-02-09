//
//  ToViewController.swift
//  UnlikeModal_Example
//
//  Created by Dev.MJ on 10/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ToViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTap() {
        dismiss(animated: true, completion: nil)
    }
}
