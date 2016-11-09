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
    
    lazy var loginHeaderLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.text = "Bahama Login"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    lazy var usernameField: UITextField = {
        let textField: UITextField = UITextField ()
        textField.borderStyle = .bezel
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField: UITextField = UITextField ()
        textField.borderStyle = .bezel
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginBtn: UIButton = {
        let btn: UIButton = UIButton (type: UIButtonType.custom)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 28.0)
        btn.backgroundColor = UIColor.init(red: 160, green: 214, blue: 90, alpha: 1.0)
        return btn
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
extension LoginView {
    fileprivate func initUI() {
        self.addSubview(self.bgImageView)
        self.addSubview(self.loginHeaderLabel)
        self.addSubview(self.usernameField)
        self.addSubview(self.passwordField)
        self.addSubview(self.loginBtn)
    }
    
    fileprivate func initLayout() {
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
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
    }
}
