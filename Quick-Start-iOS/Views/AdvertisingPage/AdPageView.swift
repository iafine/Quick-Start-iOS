//
//  AdvertisingPageView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

private let ad_time: NSInteger = 5  // 广告显示时间

class AdPageView: UIView {

    var imageFilePath: String {
        didSet(newImageFilePath) {
            
        }
    }
    
    private var adImageView: UIImageView {
        let imageView: UIImageView = UIImageView ()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(openAdWebView))
        imageView.addGestureRecognizer(tapGR)
        return imageView
    }
    
    private var skipBtn: UIButton {
        let btn: UIButton = UIButton ()
        btn.setTitle("\(ad_time)", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont .systemFont(ofSize: 15.0)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor (red: 38 / 255, green: 38 / 255, blue: 38 / 255, alpha: 0.6)
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(clickedSkipBtnHandler), for: UIControlEvents.touchUpInside)
        return btn
    }
    
    private var adTimer: Timer {
        let timer: Timer = Timer ()
        return timer
    }
    
    // MARK: - life cycle
    init(imageFilePath: String) {
        self.imageFilePath = imageFilePath
        super.init(frame: CGRect (x: 0, y: 0, width: Constants.Rect.ScreenWidth, height: Constants.Rect.ScreenHeight))
        
        initUI()
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public methods
    func show() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(self)
    }
    
    // MARK: - events
    func clickedSkipBtnHandler() {
        
    }
    
    func openAdWebView() {
        
    }
    
    // MARK: - private methods
    private func initUI() {
        self.addSubview(self.adImageView)
        self.addSubview(self.skipBtn)
    }
    
    private func initLayout() {
        // 广告图片
        self.adImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        // 跳过按钮
        self.skipBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(24)
            make.right.equalTo(self.snp.right).offset(-5)
            make.size.equalTo(CGSize (width: 60, height: 30))
        }
    }
}
