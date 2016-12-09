//
//  HYNormalRefresh.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/30.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public class HYNormalRefresh: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // 上次刷新时间缓存关键字
    public var lastRefreshTimeKey: String? = "NormalRefreshKey"
    // 刷新完成之后是否自动隐藏, 默认为false
    public var isAutomaticlyHidden: Bool? = false
    // 上次刷新时间
    public var lastRefreshTime: NSDate? = NSDate ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HYNormalRefresh: HYRefreshControl {
    public func refreshViewDidPrepare(refreshView: HYRefreshView, refreshType: HYRefreshType) {
        if refreshType == .header {
            print("下拉刷新准备开始")
        }else {
            print("上拉刷新准备开始")
        }
    }
    
    public func refreshDidBegin(refreshView: HYRefreshView, refreshType: HYRefreshType) {
        print("刷新开始")
    }
    
    public func refreshDidEnd(refreshView: HYRefreshView, refreshType: HYRefreshType) {
        print("下拉刷新结束")
    }
    
    public func refreshProgressDidChanged(refreshView: HYRefreshView, progress: CGFloat, refreshType: HYRefreshType) {
        print("刷新进度改为\(progress)")
    }
    
    public func refreshStateDidChanged(refreshView: HYRefreshView, fromState: HYRefreshStatus, toState: HYRefreshStatus, refreshType: HYRefreshType) {
        print("刷新从\(fromState)状态改变成\(toState)")
    }
}
