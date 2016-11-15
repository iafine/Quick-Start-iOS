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

}

// MARK: - LifeCycle
extension LocationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "位置"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "动画测试", style: .plain, target: self, action: #selector (clickRightBtnHandler))
    }
}

// MARK: - Events
extension LocationViewController {
    @objc fileprivate func clickRightBtnHandler() {
        let vc: AirlineViewController = AirlineViewController ()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
