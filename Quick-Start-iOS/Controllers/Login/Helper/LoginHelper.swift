//
//  LoginHelper.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/9.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class LoginHelper: NSObject {

    /// 打开登录页
    class func openLoginPage(vc: UIViewController) {
        let loginVC: LoginViewController = LoginViewController ()
        let nav: HYNavigationController = HYNavigationController ()
        nav.vc = loginVC
        vc.present(nav, animated: true, completion: nil)
    }
}
