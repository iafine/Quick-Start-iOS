//
//  AdPageView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

private let AD_TIME: NSInteger = 5  // 广告显示时间

// MARK: - Class
class AdPageView: UIView {
    
    var imageFilePath: String = "" {
        willSet {
        }
        didSet {
            self.adImageView.image = UIImage (named: imageFilePath)
        }
    }
    
    fileprivate lazy var adImageView: UIImageView = {
        let imageView: UIImageView = UIImageView ()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(openAdWebView))
        imageView.addGestureRecognizer(tapGR)
        return imageView
    }()
    
    fileprivate lazy var skipBtn: UIButton = {
        let btn: UIButton = UIButton ()
        btn.setTitle("跳过", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont .systemFont(ofSize: 15.0)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor (red: 38 / 255, green: 38 / 255, blue: 38 / 255, alpha: 0.6)
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(clickedSkipBtnHandler), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var adTimer: Timer = {
        let timer: Timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        return timer
    }()
    
    fileprivate lazy var adCount: NSInteger = {
        let count: NSInteger = 0
        return count
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
extension AdPageView {
    
    fileprivate func initUI() {
        self.addSubview(self.adImageView)
        self.addSubview(self.skipBtn)
    }
    
    fileprivate func initLayout() {
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

// MARK: - Public Methods
extension AdPageView {
    open func show() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(self)
        
        // 开始计时
        self.adCount = AD_TIME
        RunLoop.main.add(self.adTimer, forMode: RunLoopMode.commonModes)
    }
}

// MARK: - Private Methods
extension AdPageView {
    @objc fileprivate func clickedSkipBtnHandler() {
        dismiss()
    }
    
    @objc fileprivate func openAdWebView() {
        dismiss()
        
        // 发送外界跳转通知
        NotificationCenter.default.post(name: Constants.Notification.DISPATCH_AD_PAGE, object: nil, userInfo: nil)
    }
    
    @objc fileprivate func countDown() {
        self.adCount -= 1
        //        self.skipBtn.setTitle("跳过\(self.adCount)", for: UIControlState.normal)
        if self.adCount == 0 {
            dismiss()
        }
    }
    
    fileprivate func dismiss() {
        self.adTimer.invalidate()
        self.adCount = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}
