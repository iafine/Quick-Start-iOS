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

// MARK: - Notification Listen
extension HomeViewController {
    /// 广告跳转
    func pushAdViewController() {
        let adVC: AdPageViewController = AdPageViewController ()
        self.navigationController?.pushViewController(adVC, animated: true)
    }
}
