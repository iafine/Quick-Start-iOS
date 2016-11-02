//
//  HYAlertController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class HYAlertController: UIViewController {
    
    lazy var alertTable: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect (x: 0,
                                                                 y: Constants.Rect.ScreenHeight,
                                                                 width: Constants.Rect.ScreenWidth,
                                                                 height:0),
                                                  style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    fileprivate var actionArray: NSMutableArray = NSMutableArray ()
    fileprivate var cancelActionArray: NSMutableArray = NSMutableArray ()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
//        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
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
        
        // 添加主视图点击事件
//        let bgTapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(clickedBgViewHandler))
//        self.view.addGestureRecognizer(bgTapGR)
        
        initUI()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        let tableHeight: CGFloat = cellHeight * CGFloat (self.actionArray.count) + cellHeight + 10
//        self.alertTable.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view.snp.left)
//            make.right.equalTo(self.view.snp.right)
//            make.bottom.equalTo(self.view.snp.bottom)
//            make.height.equalTo(tableHeight)
//        }
//    }
    
    fileprivate func initUI() {
        self.alertTable.delegate = self
        self.alertTable.dataSource = self
        
        UIApplication.shared.keyWindow?.addSubview(self.alertTable)
    }
}

// MARK: - UITableViewDataSource
extension HYAlertController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.actionArray.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
            let action: HYAlertAction = self.actionArray.object(at: indexPath.row) as! HYAlertAction
            cell.titleLabel.text = action.title
            cell.cellIcon.image = action.image
            return cell
        }else {
            let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
            if self.cancelActionArray.count > 0 {
                let action: HYAlertAction = self.cancelActionArray.object(at: indexPath.row) as! HYAlertAction
                cell.titleLabel.text = action.title
                cell.cellIcon.image = action.image
            }else {
                cell.titleLabel.text = "取消"
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension HYAlertController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYActionSheetCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let action: HYAlertAction = self.actionArray.object(at: indexPath.row) as! HYAlertAction
            action.myHandler(action)
        }else {
            if self.cancelActionArray.count > 0 {
                let action: HYAlertAction = self.cancelActionArray.object(at: indexPath.row) as! HYAlertAction
                action.myHandler(action)
            }
        }
        dismiss()
    }
}

// MARK: - Public Methods
extension HYAlertController {
    open func addAction(action: HYAlertAction) {
        // 添加一个Action，更新约束，刷新视图
        if action.style == .cancel {
            self.cancelActionArray.add(action)
        }else {
            self.actionArray.add(action)
        }
        
        let tableHeight: CGFloat = HYActionSheetCell.cellHeight() * CGFloat (self.actionArray.count) + HYActionSheetCell.cellHeight() + 10
        
        let newTableFrame: CGRect = CGRect (x: 0,
                                            y: Constants.Rect.ScreenHeight - tableHeight,
                                            width: Constants.Rect.ScreenWidth,
                                            height: tableHeight)
        self.alertTable.frame = newTableFrame
        
        self.view.setNeedsLayout()
        self.alertTable.reloadData()
    }
}

// MARK: - UIViewControllerTransitioningDelegate
//extension HYAlertController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return HYAlertPresentSlideUp ()
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return HYAlertDismissSlideUp ()
//    }
//}

// MARK: - Events
extension HYAlertController {
    
    /// 点击背景事件
    @objc fileprivate func clickedBgViewHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods
extension HYAlertController {
    // 取消视图显示和控制器加载
    fileprivate func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
            self.alertTable.alpha = 0
        }) { (finished) in
            self.alertTable.removeFromSuperview()
            self.dismiss(animated: true, completion: nil)
        }
    }
}

