//
//  UIViewController+Utils.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/12/20.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

/// MARK: - Public Methods
extension UIViewController {
    
    /// 控制器是否可以看得见
    public var isVisible: Bool {
        return (self.isViewLoaded && (self.view.window != nil))
    }
    
    /// 控制器类名
    public var controllerName: String {
        return String(describing: type(of: self))
    }

    /// 当前显示的控制器
    ///
    /// - Returns: 当前显示的控制器
    public class func currentViewController() -> UIViewController? {
        let viewController: UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        return UIViewController.findCurrentViewController(viewController: viewController)
    }
    
    /// 当前显示的控制器类名
    ///
    /// - Returns: 当前显示的控制器类名
    public class func currentViewControllerName() -> String? {
        return String (describing: currentViewController())
    }
}

/// MARK: - Private Methods
extension UIViewController {
    fileprivate static func findCurrentViewController(viewController: UIViewController?) -> UIViewController? {
        if (viewController?.presentedViewController) != nil {
            return UIViewController.findCurrentViewController(viewController: viewController?.presentedViewController)
        }else if (viewController is UISplitViewController) {
            let splitVC: UISplitViewController = viewController as! UISplitViewController
            if splitVC.viewControllers.count > 0 {
                return UIViewController.findCurrentViewController(viewController: splitVC.viewControllers.last)
            }else {
                return splitVC
            }
        }else if (viewController is UINavigationController) {
            let navVC: UINavigationController = viewController as! UINavigationController
            if navVC.viewControllers.count > 0 {
                return UIViewController.findCurrentViewController(viewController: navVC.topViewController)
            }else {
                return navVC;
            }
        }else if (viewController is UITabBarController) {
            let tabBarVC: UITabBarController = viewController as! UITabBarController
            if (tabBarVC.viewControllers?.count)! > 0 {
                return UIViewController.findCurrentViewController(viewController: tabBarVC.selectedViewController)
            }else {
                return tabBarVC
            }
        }else {
            return viewController
        }
    }
}

