//
//  HYWebViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/24.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import WebKit

// MARK: - Class
class HYWebViewController: UIViewController {
    
    /// 请求URL
    public var requestUrl: URL!
    
    /// 是否需要显示导航栏
    public var isShowNav: Bool = false
    
    /// 网页视图
    fileprivate var webView: WKWebView = {
        let webView: WKWebView = WKWebView ()
        //开启手势交互
//        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    /// 进度条
    fileprivate var progressBar: UIProgressView = {
        let pro: UIProgressView = UIProgressView ()
        pro.progress = 0.0
        pro.trackTintColor = UIColor.clear
        pro.progressTintColor = UIColor.green
        return pro
    }()
    
    /// 返回按钮
    fileprivate var backBarButtonItem: UIBarButtonItem = {
        let backItemImage = UIImage (named: "back_indicator")
        let backButtonItem = UIBarButtonItem (image: backItemImage, style: .plain, target: self, action: #selector (clickedBackItemHandler))
        return backButtonItem
    }()
    
    /// 关闭按钮
    fileprivate var closeBarButtonItem: UIBarButtonItem = {
        let closeButtonItem = UIBarButtonItem (title: "关闭", style: .plain, target: self, action: #selector(clickedCloseItemHandler))
        return closeButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem (image: UIImage (named: "more"), style: UIBarButtonItemStyle.plain, target: self, action: #selector (clickedMoreBtnHandler))
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.load(URLRequest(url: requestUrl))
        
        self.webView.addSubview(self.progressBar)
        self.view.addSubview(self.webView)
        
        initLayout()
        
        // 监听网页进度
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isShowNav {
            self.navigationController?.navigationBar.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if !isShowNav {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

// MARK: - LifeCycle
extension HYWebViewController {
    
    fileprivate func initLayout() {
        if isShowNav {
            self.progressBar.frame = CGRect (x: 0, y: 0, width: view.frame.size.width, height: 2)
            self.webView.frame = CGRect (x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height)
        }else {
            self.progressBar.frame = CGRect (x: 0, y: 0, width: view.frame.size.width, height: 2)
            self.webView.frame = CGRect (x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height)
        }
    }
    
    ///  根据网页加载更新导航栏提示
    fileprivate func updateNavigationLeftItems() {
        if self.webView.canGoBack {
            let spaceButtonItem = UIBarButtonItem (barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            spaceButtonItem.width = -6.5
            self.navigationItem.leftBarButtonItems = [spaceButtonItem, backBarButtonItem, closeBarButtonItem]
        }else {
//            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.navigationItem.leftBarButtonItem = self.backBarButtonItem
        }
    }
}

// MARK: - WKUIDelegate
extension HYWebViewController: WKUIDelegate {
    
    // 初始化加载配置
    //    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    //
    //    }
    
    // WKWebView关闭 (iOS 9及以上)
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    // 处理js中的提示框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    // 处理js中的确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    // 处理js中的文本输入
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
    
}

// MARK: - WKNavigationDelegate
extension HYWebViewController: WKNavigationDelegate {
    
    // 网页是否可以跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {        
        // 此代理中实现这个 解决网页某些点击不跳转的问题（跨域跳转问题）
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        // 判断 request的类型
        let requestType = navigationAction.navigationType
        switch requestType {
            case .backForward: print("backForward")
            case .formResubmitted: print("formResubmitted")
            case .formSubmitted: print("formSubmitted")
            case .linkActivated: print("linkActivated")
            case .reload: print("reload")
            case .other: print("other")
        }
        
        // 更新导航栏返回按钮
        updateNavigationLeftItems()
        
        decisionHandler(.allow);
    }
    
    // 网页开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    // 网页加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 网页内容开始返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    
    }
    
    // 网页加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = isShowNav ? webView.title : ""
    }
    
    // 网页返回内容失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 网页进程终止
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}

// MARK: - Events
extension HYWebViewController {
    
    /// 点击返回事件
    func clickedBackItemHandler() {
        if self.webView.canGoBack {
            self.webView.goBack()
        }else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 点击关闭事件
    func clickedCloseItemHandler() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /// 进度条监听方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressBar.alpha = 1.0
            self.progressBar.setProgress(Float(self.webView.estimatedProgress), animated: true)
            
            // 如果进度条值大于等于0
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.progressBar.alpha = 0.0
                    }, completion: { (finished) in
                        self.progressBar.progress = 0
                })
            }
        }
    }
}

// MARK: - Private Methods
extension HYWebViewController {
}
