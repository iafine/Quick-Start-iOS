//
//  HomeViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/13.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class HomeViewController: UIViewController {

    lazy var homeView: HomeView = HomeView (frame: CGRect (x: 0, y: 0, width: Constants.Rect.ScreenWidth, height: Constants.Rect.ScreenHeight))
}

// MARK: - LifeCycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "Alert", style: .plain, target: self, action: #selector(alertTest))
        self.view.addSubview(self.homeView)
        
        /// 监听广告跳转
        NotificationCenter.default.addObserver(self, selector: #selector(pushAdViewController), name: Constants.Notification.DISPATCH_AD_PAGE, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 移除监听
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Events
extension HomeViewController {
    /// 导航栏右侧按钮事件
    @objc fileprivate func alertTest() {
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
        
        let alertVC: HYAlertController = HYAlertController ()
        let testAction: HYAlertAction = HYAlertAction (title: "您好", style: .normal) { (action) in
            print(action.title)
        }
        alertVC.addAction(action: testAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Notification Listen
extension HomeViewController {
    /// 广告跳转
    func pushAdViewController() {
        let adVC: AdPageViewController = AdPageViewController ()
        self.navigationController?.pushViewController(adVC, animated: true)
    }
}
