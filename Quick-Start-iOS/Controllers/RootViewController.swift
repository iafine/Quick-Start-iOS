//
//  RootViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: properties
    let mainVC: MainTabBarController = MainTabBarController()
    let leftVC: LeftViewController = LeftViewController()
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    /// 添加控制器和视图
    func initUI() {
        // 添加滑动手势
        let panGR: UIPanGestureRecognizer = UIPanGestureRecognizer (target: self, action: #selector(panHandler(sender:)))
        self.leftVC.view.center = CGPoint (x: -self.view.center.x, y: self.view.center.y)
        self.addChildViewController(leftVC)
        self.view.addSubview(leftVC.view)
        self.addChildViewController(mainVC)
        self.view.addSubview(mainVC.view)
        mainVC.view.addGestureRecognizer(panGR)
    }
    
    // MARK: Events
    func panHandler(sender: UIPanGestureRecognizer) {
        let translatedPoint: CGPoint = sender.translation(in: mainVC.view)
        if translatedPoint.x < 0 {
            // 右滑
            self.leftVC.view.center = CGPoint (x: 0, y: self.view.center.y)
            self.mainVC.view.center = CGPoint (x: Constants.Rect.ScreenWidth, y: self.view.center.y)
        }else {
            self.leftVC.view.center = CGPoint (x: -self.view.center.x, y: self.view.center.y)
            self.mainVC.view.center = CGPoint (x: self.view.center.x, y: self.view.center.y)
        }
    }
}
