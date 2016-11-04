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
//        let alertVC: UIAlertController = UIAlertController (title: "测试", message: "测试消息", preferredStyle: .actionSheet)
//        let oneAction: UIAlertAction = UIAlertAction (title: "第一个", style: .default) { (alert) in
//            print("one")
//        }
//        let twoAction: UIAlertAction = UIAlertAction (title: "第二个", style: .destructive) { (alert) in
//            print("two")
//        }
//        let threeAction: UIAlertAction = UIAlertAction (title: "第三个", style: .cancel) { (alert) in
//            print("three")
//        }
//        alertVC.addAction(oneAction
//        )
//        alertVC.addAction(twoAction)
//        alertVC.addAction(threeAction)
//        self.present(alertVC, animated: true, completion: nil)
        
        let alertVC: HYAlertController = HYAlertController (title: "测试", message: "消息", style: .shareSheet)
        let testAction1: HYAlertAction = HYAlertAction (title: "支付宝", image: UIImage (named: "alipay")!, style: .normal) { (action) in
            print(action.title)
        }
        let testAction2: HYAlertAction = HYAlertAction (title: "微信", image: UIImage (named: "wechat")!, style: .normal) { (action) in
            print(action.title)
        }
        let testAction3: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal) { (action) in
            print(action.title)
        }
        let testAction4: HYAlertAction = HYAlertAction (title: "知乎", image: UIImage (named: "zhihu")!, style: .normal) { (action) in
            print(action.title)
        }
        alertVC.addShareActions(actions: [testAction1, testAction2, testAction3, testAction4])
//        alertVC.addAction(action: testAction1)
//        alertVC.addAction(action: testAction2)
//        alertVC.addAction(action: testAction3)
//        alertVC.addAction(action: testAction4)
        self.present(alertVC, animated: true, completion: nil)
    }
}
