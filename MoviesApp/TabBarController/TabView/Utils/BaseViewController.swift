//
//  BaseViewController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 04/08/2024.
//

import UIKit
// to remove navigation bar from all controller
class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if self.isMovingFromParent {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.additionalSafeAreaInsets.top = 0
    }
}

