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
        return tableView
    }()
    
    fileprivate var actionArray: NSMutableArray = NSMutableArray ()
    
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
        let bgTapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(clickedBgViewHandler))
        self.view.addGestureRecognizer(bgTapGR)
        
        initUI()
//        initLayout()
        
    }
    
    fileprivate func initUI() {
        self.alertTable.delegate = self
        self.alertTable.dataSource = self
        self.alertTable.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        self.view.addSubview(self.alertTable)
    }
    
    fileprivate func initLayout() {
        self.alertTable.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(0)
        }
    }
}

// MARK: - UITableViewDataSource
extension HYAlertController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actionArray.count
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYActionSheetCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
        let action: HYAlertAction = self.actionArray.object(at: indexPath.row) as! HYAlertAction
        cell.titleLabel.text = action.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HYAlertController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Public Methods
extension HYAlertController {
    open func addAction(action: HYAlertAction) {
        // 添加一个Action，更新约束，刷新视图
        self.actionArray.add(action)
        
        let tableHeight: CGFloat = cellHeight * CGFloat (self.actionArray.count)
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
