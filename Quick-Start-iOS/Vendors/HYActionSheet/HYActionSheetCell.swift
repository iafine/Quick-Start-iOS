//
//  HYActionSheetCell.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYActionSheetCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
}

// MARK: - Class Methods
extension HYActionSheetCell {
    class func ID() -> String {
        return "HYActionSheetCell"
    }
    
    class func cellHeight() -> CGFloat {
        return 44
    }
    
    class func cellWithTableView(tableView: UITableView) ->HYActionSheetCell {
        // 修改cell类型为定义类型
        var cell: HYActionSheetCell? = tableView.dequeueReusableCell(withIdentifier: ID()) as! HYActionSheetCell?
        if cell == nil {
            cell = HYActionSheetCell ()
            cell?.initCellUI()
            cell?.initCellLayout()
        }
        return cell!
    }
}

// MARK: - Private Methods
extension HYActionSheetCell {
    fileprivate func initCellUI() {
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        self.addSubview(self.titleLabel)
    }
    
    fileprivate func initCellLayout() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
