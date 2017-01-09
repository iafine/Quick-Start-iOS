//
//  HYWebSimpleController.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/9.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit
import WebKit

class HYWebSimpleController: UIViewController {

    var requestUrl: URL!
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlRequest = URLRequest(url: requestUrl)
        webView.load(urlRequest)
    }
}
