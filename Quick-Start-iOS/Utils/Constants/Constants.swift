//
//  Constants.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    struct Rect {
        static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height    // 状态栏高度
        static let navHeight: CGFloat = 44   // 默认导航栏高度
        static let tabBarHeight: CGFloat = 49    //  默认TabBar高度
        static let ScreenWidth = UIScreen.main.bounds.size.width    // 屏幕宽度
        static let ScreenHeight = UIScreen.main.bounds.size.height  // 屏幕高度
    }
    
    struct Notification {
        static let DISPATCH_AD_PAGE = NSNotification.Name("dispatch_ad_page")   // 广告跳转通知
    }
}
