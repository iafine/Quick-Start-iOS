//
//  Plugin.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/5.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit
import WebKit

class Plugin: NSObject {
    var webView: WKWebView!
    var taskId: Int!
    var data: String?
    
    required override init() {
        
    }
    
    func callBack(results: NSDictionary) -> Bool {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: results, options: JSONSerialization.WritingOptions())
            if let jsonString = String (data: jsonData, encoding: .utf8) {
                let js = "fireTask(\(self.taskId), '\(jsonString)');"
                self.webView.evaluateJavaScript(js, completionHandler: nil)
                return true
            }
        }catch let error {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    func errorCallBack(errorMessage: String) {
        let js = "onError(\(self.taskId), '\(errorMessage)')"
        self.webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
