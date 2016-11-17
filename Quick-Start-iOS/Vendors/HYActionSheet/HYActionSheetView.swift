//
//  HYActionSheetView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/4.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol HYActionSheetViewDelegate {
    /// 点击事件
    func clickSheetItemHandler()
}

class HYActionSheetView: UIView {
    
    lazy var sheetTable: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var titleView: HYTitleView = {
        let view: HYTitleView = HYTitleView (frame: CGRect.zero)
        return view
    }()
    
    var delegate: HYActionSheetViewDelegate?
    fileprivate var sheetDataArray: NSArray = NSArray ()
    fileprivate var cancelDataArray: NSArray = NSArray ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HYActionSheetView {
    fileprivate func initUI() {
        self.sheetTable.delegate = self
        self.sheetTable.dataSource = self
        self.addSubview(self.sheetTable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sheetTable.frame = self.bounds
    }
}

// MARK: - Public Methods
extension HYActionSheetView {
    open func refreshDate(dataArray: NSArray, cancelArray: NSArray, title: String, message: String) {
        self.sheetDataArray = dataArray
        self.cancelDataArray = cancelArray
        
        if title.characters.count > 0 || message.characters.count > 0 {
            self.titleView.refrenshTitleView(title: title, message: message)
            self.titleView.frame = CGRect (x: 0, y: 0, width: self.bounds.size.width, height: HYTitleView.titleViewHeight(title: title, message: message))
            self.sheetTable.tableHeaderView = self.titleView
        }else {
            self.sheetTable.tableHeaderView = UIView ()
        }
        self.sheetTable.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HYActionSheetView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.sheetDataArray.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
            let action: HYAlertAction = self.sheetDataArray.object(at: indexPath.row) as! HYAlertAction
            cell.titleLabel.text = action.title
            cell.cellIcon.image = action.image
            return cell
        }else {
            let cell: HYActionSheetCell = HYActionSheetCell.cellWithTableView(tableView: tableView)
            if self.cancelDataArray.count > 0 {
                let action: HYAlertAction = self.cancelDataArray.object(at: indexPath.row) as! HYAlertAction
                cell.titleLabel.text = action.title
                cell.cellIcon.image = action.image
            }else {
                cell.titleLabel.text = HY_Constants.defaultCancelText
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension HYActionSheetView: UITableViewDelegate {
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
            let action: HYAlertAction = self.sheetDataArray.object(at: indexPath.row) as! HYAlertAction
            action.myHandler(action)
        }else {
            if self.cancelDataArray.count > 0 {
                let action: HYAlertAction = self.cancelDataArray.object(at: indexPath.row) as! HYAlertAction
                action.myHandler(action)
            }
        }
        delegate?.clickSheetItemHandler()
    }
}

