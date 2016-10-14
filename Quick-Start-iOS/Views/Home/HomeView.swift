//
//  HomeView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {

    // MARK: properties
    lazy var label: UILabel = {
        let tempLabel: UILabel = UILabel()
        tempLabel.backgroundColor = UIColor.red
        return tempLabel
    }()
    
    // MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 120, height: 40))
        }
    }
}
