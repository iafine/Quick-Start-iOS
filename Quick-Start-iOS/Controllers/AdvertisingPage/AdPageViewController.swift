//
//  AdPageViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import HYAlertController

// MARK: - Class
class AdPageViewController: HYWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webDelegate = self
        let url: URL = URL (string: "https://baidu.com")!
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
        
//        let alertVC: HYAlertController = HYAlertController (title: "测试", message: "This is a alert UI. you can use it equal to UIAlertController, Welcome to use it! This is a alert UI. you can use it equal to UIAlertController, Welcome to use it! This is a alert UI. you can use it equal to UIAlertController, Welcome to use it! This is a alert UI. you can use it equal to UIAlertController, Welcome to use it! This is a alert UI. you can use it equal to UIAlertController, Welcome to use it! This is a alert UI. you can use it equal to UIAlertController, Welcome to use it! This is a alert UI. you can use it equal to UIAlertController, Welcome to use it!", style: .alert)
//        let testAction1: HYAlertAction = HYAlertAction (title: "支付宝", image: UIImage (named: "alipay")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction2: HYAlertAction = HYAlertAction (title: "微信", image: UIImage (named: "wechat")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction3: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction4: HYAlertAction = HYAlertAction (title: "知乎", image: UIImage (named: "zhihu")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction11: HYAlertAction = HYAlertAction (title: "支付宝", image: UIImage (named: "alipay")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction12: HYAlertAction = HYAlertAction (title: "微信", image: UIImage (named: "wechat")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction13: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction14: HYAlertAction = HYAlertAction (title: "知乎", image: UIImage (named: "zhihu")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction21: HYAlertAction = HYAlertAction (title: "支付宝", image: UIImage (named: "alipay")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction22: HYAlertAction = HYAlertAction (title: "微信", image: UIImage (named: "wechat")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction23: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction24: HYAlertAction = HYAlertAction (title: "知乎", image: UIImage (named: "zhihu")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        alertVC.addShareActions(actions: [testAction1, testAction2, testAction3, testAction4, testAction11, testAction12, testAction13, testAction14, testAction21, testAction22, testAction23, testAction24])
//        alertVC.addShareActions(actions: [testAction1, testAction2, testAction3, testAction4, testAction11, testAction12, testAction13, testAction14, testAction21, testAction22, testAction23, testAction24])
//        alertVC.addAction(action: testAction1)
//        alertVC.addAction(action: testAction2)
//        alertVC.addAction(action: testAction3)
//        alertVC.addAction(action: testAction4)
//        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Message", style: .alert)
//        let oneAction: HYAlertAction = HYAlertAction (title: "One Action", style: .normal, handler:  { (action) in
//            print(action.title)
//        })
//        let twoAction: HYAlertAction = HYAlertAction (title: "Two Action", style: .normal, handler:  { (action) in
//            print(action.title)
//        })
//        let threeAction: HYAlertAction = HYAlertAction (title: "Three Action", style: .destructive, handler:  { (action) in
//            print(action.title)
//        })
//        let cancelAction: HYAlertAction = HYAlertAction (title: "Cancel Action", style: .cancel, handler:  { (action) in
//            print(action.title)
//        })
//        alertVC.addAction(action: oneAction)
//        alertVC.addAction(action: twoAction)
//        alertVC.addAction(action: threeAction)
//        alertVC.addAction(action: cancelAction)
//        self.present(alertVC, animated: true, completion: nil)
    }
}
