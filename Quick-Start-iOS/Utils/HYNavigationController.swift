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
        UINavigationBar.appearance().barTintColor = UIColor (red: 146/255, green: 185/255, blue: 74/255, alpha: 1.0)    // 背景颜色
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white] // 文字颜色
        self.navigationBar.isTranslucent = false    // 取消导航栏默认透明效果
    }
}
