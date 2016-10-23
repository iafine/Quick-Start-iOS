//
//  MainTabBarController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/13.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC: HomeViewController = HomeViewController()
        
        setupChildVC(vc: homeVC, title: "首页", imageName: "home", selectedImageName: "home_selected")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: private methods
    func setupChildVC(vc: UIViewController, title: NSString, imageName: NSString, selectedImageName: NSString) {
        let nav: HYNavigationController = HYNavigationController (vc: vc, title: title, imageName: imageName, selectedImageName: selectedImageName)
        addChildViewController(nav)
        
        setupTabBarAttributes()
    }
    
    func setupTabBarAttributes() {
        UITabBar.appearance().tintColor = UIColor (red: 146/255, green: 185/255, blue: 74/255, alpha: 1.0)
//        UITabBar.appearance().isTranslucent = false // 取消TabBar默认透明效果
    }
}
