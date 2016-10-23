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
        static let ScreenWidth = UIScreen.main.bounds.size.width
        static let ScreenHeight = UIScreen.main.bounds.size.height
    }
    
    struct Notification {
        static let DISPATCH_AD_PAGE = NSNotification.Name("dispatch_ad_page")   // 广告跳转通知
    }
}
