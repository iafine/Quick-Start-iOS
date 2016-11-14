//
//  Login.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/9.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class LoginView: UIView {

    lazy var bgImageView: UIImageView = {
        let imageView: UIImageView = UIImageView (image: UIImage (named: "bg-sunny"))
        return imageView
    }()
    
    lazy var cloud1: UIImageView = {
        let imageView: UIImageView = UIImageView (image: UIImage (named: "bg-sunny-cloud-1"))
        return imageView
    }()

    lazy var cloud2: UIImageView = {
        let imageView: UIImageView = UIImageView (image: UIImage (named: "bg-sunny-cloud-2"))
        return imageView
    }()
    
    lazy var cloud3: UIImageView = {
        let imageView: UIImageView = UIImageView (image: UIImage (named: "bg-sunny-cloud-3"))
        return imageView
    }()
    
    lazy var cloud4: UIImageView = {
        let imageView: UIImageView = UIImageView (image: UIImage (named: "bg-sunny-cloud-4"))
        return imageView
    }()
    
    lazy var loginHeaderLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.text = "Bahama Login"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28.0)
        return label
    }()
    
    lazy var usernameField: UITextField = {
        let textField: UITextField = UITextField ()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField: UITextField = UITextField ()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginBtn: UIButton = {
        let btn: UIButton = UIButton (type: UIButtonType.custom)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 28.0)
        btn.backgroundColor = UIColor.init(red: 160 / 255.0, green: 214 / 255.0, blue: 90 / 255.0, alpha: 1.0)
        btn.addTarget(self, action: #selector (doLog), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        view.alpha = 0.0
        return view
    }()
    
    lazy var status: UIImageView = {
        let imageView: UIImageView = UIImageView (image: UIImage (named: "banner"))
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var statusLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
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
extension LoginView {
    fileprivate func initUI() {
        self.addSubview(self.bgImageView)
        self.addSubview(self.cloud1)
        self.addSubview(self.cloud2)
        self.addSubview(self.cloud3)
        self.addSubview(self.cloud4)
        self.addSubview(self.loginHeaderLabel)
        self.addSubview(self.usernameField)
        self.addSubview(self.passwordField)
        self.addSubview(self.loginBtn)
        self.addSubview(self.status)
        
        spinner.startAnimating()
        self.loginBtn.addSubview(self.spinner)
        self.status.addSubview(self.statusLabel)
    }
    
    fileprivate func initLayout() {
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        self.cloud1.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(-120)
            make.top.equalTo(self.snp.top).offset(131)
            make.size.equalTo(CGSize (width: 159, height: 50))
        }
        
        self.cloud2.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(217)
            make.top.equalTo(self.snp.top).offset(155)
            make.size.equalTo(CGSize (width: 159, height: 50))
        }
        
        self.cloud3.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(252)
            make.bottom.equalTo(self.snp.bottom).offset(-100)
            make.size.equalTo(CGSize (width: 74, height: 35))
        }
        
        self.cloud4.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-100)
            make.size.equalTo(CGSize (width: 115, height: 50))
        }
        
        self.loginHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(90)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 215, height: 34))
        }
        
        self.usernameField.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginHeaderLabel.snp.bottom).offset(60)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 218, height: 30))
        }
        
        self.passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.usernameField.snp.bottom).offset(50)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 218, height: 30))
        }
        
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordField.snp.bottom).offset(60)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 235, height: 52))
        }
        
        self.status.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize (width: 200, height: 52))
        }
        
        self.statusLabel.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.status)
        }
    }
}

// MARK: - Public Methods
extension LoginView {
    
    /// 开始登录动画
    open func startLoginAnimate() {
        self.loginHeaderLabel.center.x  = -Constants.Rect.ScreenWidth
        self.usernameField.center.x = -Constants.Rect.ScreenWidth
        self.passwordField.center.x = -Constants.Rect.ScreenWidth
        
        self.cloud1.alpha = 0
        self.cloud2.alpha = 0
        self.cloud3.alpha = 0
        self.cloud4.alpha = 0
        
        self.loginBtn.center.y += 30
        self.loginBtn.alpha = 0
    }
    
    /// 结束登录动画
    open func endLoginAnimate() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loginHeaderLabel.center.x = self.center.x
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
            self.usernameField.center.x = self.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
            self.passwordField.center.x = self.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginBtn.center.y -= 30
            self.loginBtn.alpha = 1
        }, completion: nil)
    
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.cloud1.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.cloud2.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
            self.cloud3.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
            self.cloud4.alpha = 1.0
        }, completion: nil)
    }
}

// MARK: - Private Methods
extension LoginView {
    /// 登录动画
    fileprivate func doLoginAnimate() {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginBtn.bounds.size.width += 60
        }, completion: nil)
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
//            self.loginBtn.center.y += 60
            self.loginBtn.backgroundColor = UIColor (red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
            self.spinner.center = CGPoint (x: 40.0, y: self.loginBtn.frame.size.height/2)
            self.spinner.alpha = 1
        }, completion: nil)
    }
    
    /// 显示文字
    fileprivate func showMessage(index: Int) {
        statusLabel.text = self.messages[index]
        UIView.transition(with: self.status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
        }, completion: nil)
    }
}

// MARK: - Events
extension LoginView {
    @objc fileprivate func doLog() {
        doLoginAnimate()
        showMessage(index: 0)
    }
}
