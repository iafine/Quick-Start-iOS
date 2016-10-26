//
//  AdPageViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class AdPageViewController: HYWebViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webDelegate = self
        let url: URL = URL (string: "https://castial.github.io")!
        self.webView.load(URLRequest (url: url))
    }
}

// MARK: - HYWebViewControllerDelegate
extension HYWebViewController: HYWebViewControllerDelegate {
    
    func clickedRightBarButtonHandler() {
        let alertVC: HYAlertController = HYAlertController ()
        self.present(alertVC, animated: true, completion: nil)
    }
}
