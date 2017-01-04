//
//  MeViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/24.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

// MARK: - Class
class MeViewController: UIViewController {

}

// MARK: - Lifecycle
extension MeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "测试"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "JS交互", style: .plain, target: self, action: #selector(javascriptHandler))
    }
}

extension MeViewController {
    @objc fileprivate func javascriptHandler() {
        let webVC: HYWebTestController = HYWebTestController ()
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
