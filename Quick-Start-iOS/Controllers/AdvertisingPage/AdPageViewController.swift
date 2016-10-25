//
//  AdPageViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class AdPageViewController: HYWebViewController, HYWebViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webDelegate = self
        let url: URL = URL (string: "https://castial.github.io")!
        self.webView.load(URLRequest (url: url))
    }
    
    // MARK: - HYWebViewControllerDelegate
    func clickedRightBarButtonHandler() {
        let alertVC: HYAlertController = HYAlertController ()
        
//        alertVC.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
//        alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        alertVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(alertVC, animated: true, completion: nil)
        
    }
}
