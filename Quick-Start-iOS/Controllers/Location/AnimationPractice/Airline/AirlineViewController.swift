//
//  AirlineViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class AirlineViewController: UIViewController {
    lazy var airlineView: AirlineView = AirlineView (frame: CGRect (x: 0,
                                                                    y: 0,
                                                                    width: Constants.Rect.ScreenWidth,
                                                                    height: Constants.Rect.ScreenHeight))
}

// MARK: - LifeCycle
extension AirlineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.airlineView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 登录页导航栏透明
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage (), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage ()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 登录页消失，取消导航栏透明
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
}
