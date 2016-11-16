//
//  HYAlertController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public enum HYAlertControllerStyle : Int {
    
    case actionSheet
    
    case shareSheet
    
    case alert
}

// MARK: - Class
class HYAlertController: UIViewController {

    var alertTitle: String
    var alertMessage: String
    var alertStyle: HYAlertControllerStyle
    
    fileprivate var actionArray: NSMutableArray = NSMutableArray ()
    fileprivate var cancelActionArray: NSMutableArray = NSMutableArray ()
    
    var alertHeight: CGFloat = CGFloat()

    lazy var shareView: HYShareView = {
        let view: HYShareView = HYShareView (frame: CGRect.zero)
        return view
    }()
    
    lazy var sheetView: HYActionSheetView = {
        let view: HYActionSheetView = HYActionSheetView (frame: CGRect.zero)
        return view
    }()
    
    lazy var dimBackgroundView: UIView = {
        let view: UIView = UIView (frame: CGRect (x: 0,
                                                  y: 0,
                                                  width: HY_Constants.ScreenWidth,
                                                  height: HY_Constants.ScreenHeight))
        view.backgroundColor = UIColor (white: 0, alpha: HY_Constants.dimBackgroundAlpha)
        view.alpha = 0
        
        // 添加手势监听
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector (clickedBgViewHandler))
        view.addGestureRecognizer(tapGR)
        return view
    }()
    
    init(title: String?, message: String?, style: HYAlertControllerStyle) {
        self.alertTitle = title!
        self.alertMessage = message!
        self.alertStyle = style
        super.init(nibName: nil, bundle: nil)
        
        // 自定义转场动画
        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYAlertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear

        initUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.alertStyle == .shareSheet {
            let tableHeight: CGFloat = HYShareTableViewCell.cellHeight() * CGFloat (self.actionArray.count) + 44
            let newTableFrame: CGRect = CGRect (x: 0,
                                                y: HY_Constants.ScreenHeight - tableHeight,
                                                width: HY_Constants.ScreenWidth,
                                                height: tableHeight)
            self.alertHeight = tableHeight
            self.shareView.frame = newTableFrame
        }else {
            let tableHeight: CGFloat = HYActionSheetCell.cellHeight() * CGFloat (self.actionArray.count) + HYActionSheetCell.cellHeight() + 10
            
            let newTableFrame: CGRect = CGRect (x: 0,
                                                y: HY_Constants.ScreenHeight - tableHeight,
                                                width: HY_Constants.ScreenWidth,
                                                height: tableHeight)
            self.alertHeight = tableHeight
            self.sheetView.frame = newTableFrame
        }
    }
    
    fileprivate func initUI() {
        self.view.addSubview(self.dimBackgroundView)
        switch self.alertStyle {
        case .actionSheet:
            self.sheetView.delegate = self
            self.view.addSubview(self.sheetView)
            break
            
        case .shareSheet:
            self.shareView.delegate = self
            self.view.addSubview(self.shareView)
            break
            
        default: break
            
        }
    }
}

// MARK: - Public Methods
extension HYAlertController {
    open func addAction(action: HYAlertAction) {
        if action.style == .cancel {
            self.cancelActionArray.add(action)
        }else {
            self.actionArray.add(action)
        }
        self.sheetView.refreshDate(dataArray: self.actionArray, cancelArray: self.cancelActionArray)
    }
    
    open func addShareActions(actions: NSArray) {
        self.actionArray.add(actions)
        self.shareView.refreshDate(dataArray: self.actionArray, cancelArray: self.cancelActionArray)
    }
}

// MARK: - HYActionSheetViewDelegate
extension HYAlertController: HYActionSheetViewDelegate {
    func clickSheetItemHandler() {
        dismiss()
    }
}

// MARK: - HYShareViewDelegate
extension HYAlertController: HYShareViewDelegate {
    func clickedShareItemHandler() {
        dismiss()
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension HYAlertController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertPresentSlideUp ()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertDismissSlideUp ()
    }
}

// MARK: - Events
extension HYAlertController {
    
    /// 点击背景事件
    @objc fileprivate func clickedBgViewHandler() {
        dismiss()
    }
}

// MARK: - Private Methods
extension HYAlertController {
    // 取消视图显示和控制器加载
    fileprivate func dismiss() {
        self.actionArray.removeAllObjects()
        self.cancelActionArray.removeAllObjects()
        
        self.dismiss(animated: true, completion: nil)
    }
}

