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
    
    let distance: CGFloat = 0
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    /// 添加控制器和视图
    func initUI() {
        self.addChildViewController(mainVC)
        self.view.addSubview(mainVC.view)
        // 添加滑动手势
//        let panGR: UIPanGestureRecognizer = UIPanGestureRecognizer (target: self, action: #selector(panHandler(sender:)))
//        self.leftVC.view.center = CGPoint (x: -self.view.center.x, y: self.view.center.y)
//        self.addChildViewController(leftVC)
//        self.view.addSubview(leftVC.view)
//        mainVC.view.addGestureRecognizer(panGR)
//        self.view.bringSubview(toFront: mainVC.view)
    }
    
    // MARK: Events
    func panHandler(sender: UIPanGestureRecognizer) {
        let x = sender.translation(in: mainVC.view).x
        
        if x > 0 {
            sender.view?.center = CGPoint (x: self.view.center.x + x, y: self.view.center.y)
        }
        
        // 手势结束
        if sender.state == UIGestureRecognizerState.ended {
            if x > Constants.Rect.ScreenWidth * 1/3 {
                // 显示左视图
                showLeft()
            }else {
                // 返回首页
                showHome()
            }
        }
    }
    
    func showLeft() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.leftVC.view.center = CGPoint (x: 0, y: self.view.center.y)
            self.mainVC.view.center = CGPoint (x: Constants.Rect.ScreenWidth, y: self.view.center.y)
            }, completion: nil)
    }
    
    func showHome() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.leftVC.view.center = CGPoint (x: -self.view.center.x, y: self.view.center.y)
            self.mainVC.view.center = CGPoint (x: self.view.center.x, y: self.view.center.y)
            }, completion: nil)
    }
}
