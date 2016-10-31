//
//  HYWebViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/24.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import WebKit

// MARK: - Protocol
protocol HYWebViewControllerDelegate {
    
    /// 导航栏右侧按钮点击事件
    func clickedRightBarButtonHandler()
}

// MARK: - Class
class HYWebViewController: UIViewController {

    var webDelegate: HYWebViewControllerDelegate?
    
    var webView: WKWebView = {
        let webView: WKWebView = WKWebView ()
        return webView
    }()
    
    var progressBar: UIProgressView = {
        let pro: UIProgressView = UIProgressView ()
        pro.progress = 0.0
        pro.backgroundColor = UIColor.blue
        return pro
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (image: UIImage (named: "more"), style: UIBarButtonItemStyle.plain, target: self, action: #selector (clickedMoreBtnHandler))
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        self.view.addSubview(self.progressBar)
        self.view.addSubview(self.webView)
        
        initLayout()
        
        // 监听网页进度
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

// MARK: - LifeCycle
extension HYWebViewController {
    
    fileprivate func initLayout() {
        self.progressBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.view.snp.top)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(2)
        }
        
        self.webView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.progressBar.snp.bottom)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
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
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //
    //    }
    
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
        self.title = webView.title
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
    
    /// 点击导航栏右侧更多事件
    func clickedMoreBtnHandler() {
        webDelegate?.clickedRightBarButtonHandler()
    }
}
