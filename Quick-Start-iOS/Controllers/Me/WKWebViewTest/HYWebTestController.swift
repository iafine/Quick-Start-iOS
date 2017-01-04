//
//  HYWebTestController.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/4.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit
import WebKit

class HYWebTestController: UIViewController {

    fileprivate var webView: WKWebView {
        // 注册scriptMessageHandler
        let conf = WKWebViewConfiguration ()
        conf.userContentController.add(self, name: "HY")
        let webview: WKWebView = WKWebView (frame: CGRect (x: 0,
                                                y: 0,
                                                width: Constants.Rect.ScreenWidth,
                                                height: Constants.Rect.ScreenHeight),
                                 configuration: conf)
        webview.navigationDelegate = self
        webview.uiDelegate = self
        webview.load(URLRequest (url: URL (string: "https://www.baidu.com")!))
        return webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "Javascript交互"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 添加插件
        self.runPluginsJS(names: ["Console"])
        self.view.addSubview(self.webView)
    }
}

extension HYWebTestController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}

extension HYWebTestController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController (title: webView.title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction (title: "OK", style: .cancel, handler: { (action) in
            completionHandler()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension HYWebTestController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "HY" {
            if let dic = message.body as? NSDictionary {
                let className = dic["className"] as! String
                let functionName = dic["functionName"] as! String
                // 注意：如果工程名字包含"-"，需要转换成"_"
                let namespace = (Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String).replacingOccurrences(of: "-", with: "_")
                if let cls = NSClassFromString("\(namespace).\(className)") as? NSObject.Type {
                    let obj = cls.init()
                    let functionSelector = Selector (functionName + ":")
                    if obj.responds(to: functionSelector) {
                        obj.perform(functionSelector, with: dic["data"])
                    }else {
                        print("This function isn't found!")
                    }
                }else {
                    print("This class isn't found!")
                }
            }
        }
    }
}

extension HYWebTestController {
    fileprivate func runPluginsJS (names: Array<String>) {
        for name in names {
            if let path = Bundle.main.path(forResource: name, ofType: "js", inDirectory: "www/plugins") {
                do {
                    let js = try String (contentsOfFile: path, encoding: .utf8)
                    self.webView.evaluateJavaScript(js as String, completionHandler: nil)
                }catch let error as Error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
