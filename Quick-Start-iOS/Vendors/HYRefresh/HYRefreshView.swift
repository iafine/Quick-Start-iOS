//
//  HYRefreshView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/29.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public enum HYRefreshStatus {
    
    case normal     // 正常状态
    
    case loading    // 加载状态
    
    case pull       // 下拉状态
    
    case release    // 松手状态
}

public enum HYRefreshType {
    case header
    
    case footer
}

public class HYRefreshView: UIView {

    /// KVO Constant
    struct ConstantValue {
        static var RefreshViewContext: UInt8 = 0
        static let ScrollViewContentOffsetPath = "contentOffset"
        static let ScrollViewContentSizePath = "contentSize"
        static let commonRefreshTimeKey = "ZJCommonRefreshTimeKey"
        static let LastRefreshTimeKey = ProcessInfo().globallyUniqueString
    }

    typealias HYRefreshHandler = () -> Void
    
    var canBegin = false {
        didSet {
            if canBegin == oldValue {
                return
            }
            if canBegin {
                // 开始动画
                startAnimation()
            }else {
                // 结束动画
                endAnimation()
            }
        }
    }
    
    // MARK: - private property
    private var refreshStatus: HYRefreshStatus = .normal {
        didSet {
            if refreshStatus == .normal {
                isHidden = refreshControl.isAutomaticlyHidden
            }else {
                isHidden = false
            }
            
            if refreshStatus != oldValue {
                if refreshStatus == .loading {
                    refreshControl.lastRefreshTime = NSDate ()
                }
                refreshControl.refreshStateDidChanged(refreshView: self, fromState: oldValue, toState: refreshStatus, refreshType: refreshType)
            }
        }
    }
    
    private let refreshHandler: HYRefreshHandler
    
    private var refreshControl: HYRefreshControl

    private var refreshType: HYRefreshType = .header
    
    private var isRefreshing = false    // 是否正在刷新
    
    private var isDragBegin = false     // 是否开始拖动
    
    private var footerAppearOffsetY: CGFloat = 0
    
    private var insetTopDelta: CGFloat = 0
    
    private var isAnimating = false     // 动画是否执行完成

    // 重置ScrollView属性
    private var scrollViewOriginValue:(bounces: Bool, contentInsetTop: CGFloat, contentInsetBottom: CGFloat, contentOffset: CGPoint) = (false, 0, 0, CGPoint())
    
    private weak var scrollView: UIScrollView? {
        return self.superview as? UIScrollView
    }
    
    //MARK: - life cycle
    init<Control: UIView>(frame: CGRect, refreshType: HYRefreshType, refreshControl: Control, refreshHandler: @escaping HYRefreshHandler) where Control: HYRefreshControl {
        self.refreshType = refreshType
        self.refreshControl = refreshControl
        self.refreshHandler = refreshHandler
        super.init(frame: frame)
        
        // 添加刷新控件
        addSubview(refreshControl)
        autoresizingMask = .flexibleWidth   // 添加约束
        addLayoutConstraint()
        
        /// 打开refreshControl代理调用
        refreshControl.refreshViewDidPrepare(refreshView: self, refreshType: refreshType)
        
        isHidden = refreshControl.isAutomaticlyHidden
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 约束设置
    private func addLayoutConstraint(){
        guard let refreshControlView = refreshControl as? UIView else {
            return
        }
        
        refreshControlView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = NSLayoutConstraint (item: refreshControlView,
                                          attribute: .leading,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .leading,
                                          multiplier: 1.0,
                                          constant: 0.0)
        let top = NSLayoutConstraint (item: refreshControlView,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: .top,
                                      multiplier: 1.0,
                                      constant: 0.0)
        let trailing = NSLayoutConstraint (item: refreshControlView,
                                           attribute: .trailing,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .trailing,
                                           multiplier: 1.0,
                                           constant: 0.0)
        let bottom = NSLayoutConstraint (item: refreshControlView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0.0)
        
        addConstraints([leading, top, trailing, bottom])
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &ConstantValue.RefreshViewContext {
            if keyPath == ConstantValue.ScrollViewContentSizePath {
                guard let validScrollView = scrollView,
                    let oldSize = (change?[NSKeyValueChangeKey.oldKey] as AnyObject).cgSizeValue,
                    let newSize = (change?[NSKeyValueChangeKey.newKey] as AnyObject).cgSizeValue,
                    oldSize != newSize && refreshType == .footer
                    else { return }
                
                // 获取屏幕上的内容高度
                let contentOnScreenHeight = heightOfContentOnScreenOfScrollView(scrollView: validScrollView)
                
                self.frame.origin.y = max(newSize.height, contentOnScreenHeight)
                
            }else if keyPath == ConstantValue.ScrollViewContentOffsetPath {
                if let validScrollView = scrollView, object as? UIScrollView == validScrollView {
                    if refreshType == .header {
                        // 调整header，当scrollView滚动的时候
                        updateHeaderWhenIsScrolling(scrollView: validScrollView)
                    }else {
                        // 调整footer，当scrollView滚动的时候
                        updateFooterWhenIsScrolling(scrollView: validScrollView)
                    }
                }
            }else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    /// 显示在屏幕上的内容高度
    private func heightOfContentOnScreenOfScrollView(scrollView: UIScrollView) -> CGFloat {
        return scrollView.bounds.height - scrollView.contentInset.top - scrollView.contentInset.bottom
    }
    
    private func updateHeaderWhenIsScrolling(scrollView: UIScrollView) {
        if isRefreshing {
            if self.window == nil {
                return
            }
            //TODO: 需要处理sectionHeader悬停的问题
            return
        }
        
        // 如果不是刷新状态，记录下contentInset
        if isAnimating {
            return
        }
        
        scrollViewOriginValue.contentInsetTop = scrollView.contentInset.top
        
        // 手势拖拽才能进入下拉状态
        if scrollView.panGestureRecognizer.state == .began {
            isDragBegin = true
            isHidden = false
            return
        }
        
        // 如果没有拖拽，直接返回，如果已经进入拖拽状态，那么进行相关操作
        if !isDragBegin {
            return
        }
        
        // 计算下拉进度，下拉进度 = 下拉的高度 % 刷新视图的高度
        let progress = (-scrollViewOriginValue.contentInsetTop - scrollView.contentOffset.y) / self.bounds.height
        
        // 根据下拉高度进度更新刷新视图的状态
        updateRefreshView(progress: progress, scrollView: scrollView)
    }
    
    private func updateFooterWhenIsScrolling(scrollView: UIScrollView) {
        if isRefreshing || isAnimating {
            // 如果正在刷新，直接返回
            return
        }
        
        scrollViewOriginValue.contentInsetBottom = scrollView.contentInset.bottom

        // 手势拖拽进入下拉状态
        if scrollView.panGestureRecognizer.state == .began {
            isDragBegin = true
            footerAppearOffsetY = frame.origin.y - scrollView.bounds.height
            isHidden = false
            return
        }
        
        // 如果没有拖拽，直接返回
        if !isDragBegin {
            return
        }
        
        // 如果视图还没有下拉到最底层
        if scrollView.contentOffset.y < footerAppearOffsetY {
            return
        }
        
        // 计算下拉进度，下拉进度 = 下拉的高度 % 刷新视图的高度
        let progress = (scrollView.contentOffset.y - footerAppearOffsetY) / self.bounds.height
        
        // 根据下拉高度进度更新刷新视图的状态
        updateRefreshView(progress: progress, scrollView: scrollView)
    }
    
    private func updateRefreshView(progress: CGFloat, scrollView: UIScrollView) {
        if scrollView.isTracking {
            // 如果scrollView还在用户的拖动中
            if progress >= 1.0 {
                refreshStatus = .release
            }else if progress <= 0.0 {
                refreshStatus = .normal
            }else {
                refreshStatus = .pull
            }
        }else if refreshStatus == .release {
            canBegin = true
        }else {
            if progress <= 0.0 {
                refreshStatus = .normal
            }
        }
        
        var actualProgress = min(1.0, progress)
        actualProgress = max(0.0, actualProgress)
        
        // 根据下拉进度更新刷新视图显示
        refreshControl.refreshProgressDidChanged(refreshView: self, progress: progress, refreshType: refreshType)
    }
    
    /// 开始刷新动画
    private func startAnimation(){
        guard let validScrollView = scrollView else {
            return
        }
        validScrollView.bounces = false
        isRefreshing = true
        
        // update UI
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: { 

            })
            UIView.animate(withDuration: 0.25, animations: {
                if self.refreshType == .header {
                    validScrollView.contentInset.top = self.scrollViewOriginValue.contentInsetTop + self.bounds.height
                }else {
                    let offPartHeight = validScrollView.contentSize.height - self.heightOfContentOnScreenOfScrollView(scrollView: validScrollView)
                    let notSureBottom = self.scrollViewOriginValue.contentInsetBottom + self.bounds.height
                    validScrollView.contentInset.bottom = offPartHeight >= 0 ? notSureBottom : notSureBottom - offPartHeight
                }
            }, completion: { (isFinish) in
                // 开始刷新
                validScrollView.bounces = true
                self.isDragBegin = false
                self.refreshStatus = .loading
                /// 回调刷新开始
                self.refreshControl.refreshDidBegin(refreshView: self, refreshType: self.refreshType)
                // 回调
                self.refreshHandler()
            })
        }
    }
    
    // 结束刷新动画
    private func endAnimation() {
        guard let validScrollView = scrollView else {
            return
        }
        
        if !isRefreshing {
            return
        }
        
        isRefreshing = false
        isAnimating = true
        
        // update UI
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: { 
                if self.refreshType == .header {
                    validScrollView.contentInset.top += self.insetTopDelta
                }else {
                    validScrollView.contentInset.bottom = self.scrollViewOriginValue.contentInsetBottom
                }
            }, completion: { (isFinished) in
                // 刷新结束，恢复到初始状态
                validScrollView.bounces = self.scrollViewOriginValue.bounces
                self.isAnimating = false
                // 回调刷新状态改变
                self.refreshControl.refreshProgressDidChanged(refreshView: self, progress: 1.0, refreshType: self.refreshType)
                // 回调刷新结束
                self.refreshControl.refreshDidEnd(refreshView: self, refreshType: self.refreshType)
                self.refreshStatus = .normal
                // 刷新控件是否隐藏
                self.isHidden = self.refreshControl.isAutomaticlyHidden
            })
        }
    }
}
