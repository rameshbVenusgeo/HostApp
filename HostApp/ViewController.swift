//
//  ViewController.swift
//  HostApp
//
//  Created by venusgeo on 03/10/21.
//  Copyright © 2021 venusgeo. All rights reserved.
//

import UIKit
import PassPortScanner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRootViewController()
    }
    
    private func setupRootViewController() {
        guard let viewcontroller = PassPortScanner().getRootViewController() else {
            return
        }
        self.addChild(viewcontroller)
        self.view.addSubview(viewcontroller.view)
        viewcontroller.didMove(toParent: self)
    }
}

