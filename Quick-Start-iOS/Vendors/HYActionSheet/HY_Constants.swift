//
//  HY_Constants.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HY_Constants: UIView {
    
    static let ScreenWidth = UIScreen.main.bounds.size.width    // 屏幕宽度
    static let ScreenHeight = UIScreen.main.bounds.size.height  // 屏幕高度
    
    static let actionSheetheight: CGFloat = 44  // ActionSheet的高度
    
    static let shareItemHeight: CGFloat = 100   // 分享item的高度
    static let shareItemWidth: CGFloat = 72     // 分享item的宽度
    static let shareItemPadding: CGFloat = 14   // 分享item之间的距离
    static let shareCancelItemHeight: CGFloat = 49   // 分享底部取消的高度

    static let presentAnimateDuration: TimeInterval = 0.7   // present动画时间
    static let dismissAnimateDuration: TimeInterval = 0.7   // dismiss动画时间
    
    static let dimBackgroundAlpha: CGFloat = 0.4    // 半透明背景的alpha值
    
    static let defaultCancelText: String = "取消"     // 默认取消按钮文字
}
