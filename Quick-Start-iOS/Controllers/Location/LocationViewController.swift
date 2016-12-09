//
//  LocationViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/24.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class LocationViewController: UIViewController {
    lazy var shakeBtn: ShakeButton = {
        let button: ShakeButton = ShakeButton ()
        button.setTitle("抖动", for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector (clickedShakeBtnHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var shakeImageView: ShakeImageView = {
        let imageView: ShakeImageView = ShakeImageView ()
        imageView.image = UIImage (named: "launchimage")
        return imageView
    }()
}

// MARK: - LifeCycle
extension LocationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "面向协议编程"
  
        initUI()
        initLayout()
    }
    
    fileprivate func initUI() {
        self.view.addSubview(self.shakeBtn)
        self.view.addSubview(self.shakeImageView)
        
        print("Center: x: \(self.view.center.x), y: \(self.view.center.y)")
    }
    
    fileprivate func initLayout() {
        self.shakeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize (width: 80, height: 190))
        }
        self.shakeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.shakeImageView.snp.bottom).offset(10)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize (width: 160, height: 40))
        }
    }
}

// MARK: - Events
extension LocationViewController {
    @objc fileprivate func clickedShakeBtnHandler() {
//        shakeImageView.shake()
        shakeBtn.shake()
    }
}
