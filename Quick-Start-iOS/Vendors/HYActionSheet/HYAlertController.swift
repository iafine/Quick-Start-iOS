//
//  HYAlertController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

fileprivate let identifier: String = "Cell"
fileprivate let cellHeight: CGFloat = 44

// MARK: - Class
class HYAlertController: UIViewController {
    
    lazy var alertTable: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect (x: 0,
                                                                 y: Constants.Rect.ScreenHeight,
                                                                 width: Constants.Rect.ScreenWidth,
                                                                 height:0),
                                                  style: .plain)
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
    
    fileprivate func initUI() {
        self.alertTable.delegate = self
        self.alertTable.dataSource = self
        
        self.view.addSubview(self.alertTable)
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
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYActionSheetCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
            let action: HYAlertAction = self.actionArray.object(at: indexPath.row) as! HYAlertAction
            cell.titleLabel.text = action.title
            return cell
        }else {
            let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
            if self.cancelActionArray.count > 0 {
                let action: HYAlertAction = self.cancelActionArray.object(at: indexPath.row) as! HYAlertAction
                cell.titleLabel.text = action.title
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
        
        self.dismiss(animated: true, completion: nil)
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
        
        let tableHeight: CGFloat = cellHeight * CGFloat (self.actionArray.count) + cellHeight + 10
        
        let newTableFrame: CGRect = CGRect (x: 0,
                                            y: Constants.Rect.ScreenHeight - tableHeight,
                                            width: Constants.Rect.ScreenWidth,
                                            height: tableHeight)
        self.alertTable.frame = newTableFrame
        
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

