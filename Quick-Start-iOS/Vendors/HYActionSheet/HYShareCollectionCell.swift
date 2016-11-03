//
//  HYShareCollectionCell.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/2.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYShareCollectionCell: UICollectionViewCell {
    lazy var cellIcon: UIImageView = {
        let imageView: UIImageView = UIImageView ()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCellUI()
        initCellLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Class Methods
extension HYShareCollectionCell {
    class func ID() -> String {
        return "HYShareCollectionCell"
    }
    
    class func cellSize() -> CGSize {
        return CGSize (width: 50, height: 80)
    }
    
    class func cellInset() -> UIEdgeInsets {
        return UIEdgeInsets (top: 10, left: 10, bottom: 10, right: 10)
    }
}

// MARK: - Private Methods
extension HYShareCollectionCell {
    fileprivate func initCellUI() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.cellIcon)
    }
    
    fileprivate func initCellLayout() {
        self.cellIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(self.snp.width)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.cellIcon.snp.bottom).offset(5)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
