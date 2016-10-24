//
//  AdPageViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class AdPageViewController: HYWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: URL = URL (string: "https://castial.github.io")!
        self.webView.load(URLRequest (url: url))
    }
}
