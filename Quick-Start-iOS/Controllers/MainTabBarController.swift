//
//  MainTabBarController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/13.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class MainTabBarController: UITabBarController {
}

// MARK: - LifeCycle
extension MainTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC: HomeViewController = HomeViewController()
        let locationVC: LocationViewController = LocationViewController()
        let meVC: MeViewController = MeViewController()
        
        setupChildVC(vc: homeVC, title: "首页", imageName: "home", selectedImageName: "home_selected")
        setupChildVC(vc: locationVC, title: "位置", imageName: "location", selectedImageName: "location_selected")
        setupChildVC(vc: meVC, title: "测试", imageName: "me", selectedImageName: "me_selected")
    }
}

// MARK: - Private Methods
extension MainTabBarController {
    fileprivate func setupChildVC(vc: UIViewController, title: NSString, imageName: NSString, selectedImageName: NSString) {
        let nav: HYNavigationController = HYNavigationController ()
        nav.vc = vc
        nav.navTitle = title as String
        nav.imageName = imageName as String
        nav.selectedImageName = selectedImageName as String
        addChildViewController(nav)
        
        setupTabBarAttributes()
    }
    
    fileprivate func setupTabBarAttributes() {
        UITabBar.appearance().tintColor = UIColor (red: 146/255, green: 185/255, blue: 74/255, alpha: 1.0)
        //        UITabBar.appearance().isTranslucent = false // 取消TabBar默认透明效果
    }
}
