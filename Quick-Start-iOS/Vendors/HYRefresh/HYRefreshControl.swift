//
//  HYRefreshControl.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/30.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public protocol HYRefreshControl {
    // 上次刷新时间缓存关键字
    var lastRefreshTimeKey: String? { get }
    // 刷新完成之后是否自动隐藏, 默认为false
    var isAutomaticlyHidden: Bool? { get }
    // 上次刷新时间
    var lastRefreshTime: NSDate? { get set }
    
    /** ! 自定义必须实现下面三个代理方法 **/
    
    // 开始进入刷新状态，开启刷新动画
    func refreshDidBegin(refreshView: HYRefreshView, refreshType: HYRefreshType)
    // 刷新结束状态，关闭刷新动画
    func refreshDidEnd(refreshView: HYRefreshView, refreshType: HYRefreshType)
    // 刷新状态改变，自定义各个状态的属性
    func refreshStateDidChanged(refreshView: HYRefreshView, fromState: HYRefreshStatus, toState: HYRefreshStatus, refreshType: HYRefreshType)
    
    /** ! 自定义可选代理方法 **/
    
    // 刷新控件添加到UIScrollView之前的准备
    func refreshViewDidPrepare(refreshView: HYRefreshView, refreshType: HYRefreshType)
    
    // 拖拽进度发生变化，用于自定义拖拽过程动画
    func refreshProgressDidChanged(refreshView: HYRefreshView, progress: CGFloat, refreshType: HYRefreshType)
}

/// MARK: - Default Settings
extension HYRefreshControl {
    func refreshViewDidPrepare(refreshView: HYRefreshView, refreshType: HYRefreshType) {
    }
    
    func refreshProgressDidChanged(refreshView: HYRefreshView, progress: CGFloat, refreshType: HYRefreshType) {
    }
    
    var isAutomaticlyHidden: Bool {
        return false
    }
    
    var lastRefreshTime: NSDate? {
        get {
            return UserDefaults.standard.object(forKey: lastRefreshTimeKey ?? "HYRefreshTimeKey") as! NSDate?
        }
        set {
            UserDefaults.standard.set(newValue, forKey: lastRefreshTimeKey ?? "HYRefreshTimeKey")
            UserDefaults.standard.synchronize()
        }
    }
    
    var lastRefreshTimeKey: String? {
        return nil
    }
}
