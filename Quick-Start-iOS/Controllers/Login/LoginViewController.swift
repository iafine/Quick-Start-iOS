//
//  LoginViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/9.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView: LoginView = LoginView (frame: CGRect (x: 0, y: 0, width: Constants.Rect.ScreenWidth, height: Constants.Rect.ScreenHeight))
    
}

// MARK: - LifeCycle
extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem (title: "退出", style: .plain, target: self, action: #selector (dismissViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "下一步", style: .plain, target: self, action: #selector (openNextViewController))
        self.view.addSubview(self.loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 登录页导航栏透明
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage (), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage ()
        
        print("\(self.loginView.loginHeaderLabel.center.x)")
        self.loginView.loginHeaderLabel.center.x -= self.view.bounds.width
        self.loginView.usernameField.center.x -= self.view.bounds.width
        self.loginView.passwordField.center.x -= self.view.bounds.width
        print("\(self.loginView.loginHeaderLabel.center.x)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.loginView.endLoginAnimate()
        print("\(self.loginView.loginHeaderLabel.center.x)")
        UIView.animate(withDuration: 0.5, animations: {
            self.loginView.loginHeaderLabel.center.x += self.view.bounds.width
            print("\(self.loginView.loginHeaderLabel.center.x)")
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.loginView.usernameField.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.loginView.passwordField.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 登录页消失，取消导航栏透明
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Events
extension LoginViewController {
    @objc fileprivate func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func openNextViewController() {
        let nextVC: MeViewController = MeViewController ()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
