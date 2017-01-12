//
//  HYNavigationController.swift
//  Quick-Start-iOS (自定义导航栏)
//
//  Created by work on 2016/10/23.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class HYNavigationController: UINavigationController {

    var vc: UIViewController = UIViewController() {
        willSet {
        }
        didSet {
            self.viewControllers = [vc]
        }
    }
    
    var navTitle: String = String() {
        willSet {
        }
        didSet {
            self.tabBarItem.title = navTitle
        }
    }
    
    var imageName: String = String() {
        willSet {
        }
        didSet {
            self.tabBarItem.image = UIImage (named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
    
    var selectedImageName: String = String() {
        willSet {
        }
        didSet {
            self.tabBarItem.selectedImage = UIImage (named: selectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
}

// MARK: - LifeCycle
extension HYNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarAttributes()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Private Methods
extension HYNavigationController {
    fileprivate func setupNavigationBarAttributes() {
        // 声明导航栏属性
        let navTitleColor = UIColor (red: 0.322, green: 0.322, blue: 0.322, alpha: 1.0)
        let navBarFont = UIFont.boldSystemFont(ofSize: 16)
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: navTitleColor, NSFontAttributeName:navBarFont]
        UINavigationBar.appearance().tintColor = UIColor (red: 0.322, green: 0.322, blue: 0.322, alpha: 1.0)
        UINavigationBar.appearance().backIndicatorImage = UIImage (named: "back_indicator")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage (named: "back_indicator")

        // UIBarButtonBar属性
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:navTitleColor, NSFontAttributeName:UIFont.systemFont(ofSize: 14)], for: .normal)
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0 , -60), for: .default)
    }
}
