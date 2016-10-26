//
//  HomeView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Class
class HomeView: UIView {

    // MARK: properties
    lazy var label: UILabel = {
        let tempLabel: UILabel = UILabel()
        tempLabel.backgroundColor = UIColor.red
        return tempLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initUI()
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HomeView {
    fileprivate func initUI() {
        self.addSubview(self.label)
    }
    
    fileprivate func initLayout() {
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 120, height: 40))
        }
    }
}
