//
//  UIScrollView+HYRefresh.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

private var HY_Header_Key: UInt8 = 0
private var HY_Footer_Key: UInt8 = 0

extension UIScrollView {
    
    public typealias HYRefreshHandler = () -> Void
    
    private var hy_header: HYRefreshView? {
        set {
            objc_setAssociatedObject(self,
                                     &HY_Header_Key,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &HY_Header_Key) as? HYRefreshView
        }
    }
    
    private var hy_footer: HYRefreshView? {
        set {
            objc_setAssociatedObject(self,
                                     &HY_Footer_Key,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &HY_Footer_Key) as? HYRefreshView
        }
    }
    
    public func hy_refreshHeader<Control: UIView>(headerControl: Control, refreshHandler: @escaping HYRefreshHandler) where Control: HYRefreshControl {
        if hy_header != nil {
            hy_header?.removeFromSuperview()
        }
        
        let headerFrame = CGRect (x: 0, y: -headerControl.bounds.height, width: bounds.width, height: headerControl.bounds.height)

        hy_header = HYRefreshView (frame: headerFrame, refreshType: .header, refreshControl: headerControl, refreshHandler: refreshHandler)
        addSubview(hy_header!)
    }
    
    public func hy_refreshFooter<Control: UIView>(footerControl: Control, refreshHandler: @escaping HYRefreshHandler) where Control: HYRefreshControl {
        if hy_footer != nil {
            hy_footer?.removeFromSuperview()
        }
        
        let footerFrame = CGRect (x: 0, y: contentSize.height, width: bounds.width, height: footerControl.bounds.height)

        hy_footer = HYRefreshView (frame: footerFrame, refreshType: .footer, refreshControl: footerControl, refreshHandler: refreshHandler)
        addSubview(hy_footer!)
    }
    
    public func hy_startHeaderAnimation() {
        hy_header?.canBegin = true
    }
    
    public func hy_endHeaderAnimation() {
        hy_header?.canBegin = false
    }
    
    public func hy_startFooterAnimation() {
        hy_footer?.canBegin = true
    }
    
    public func hy_endFooterAnimation() {
        hy_footer?.canBegin = false
    }
}
