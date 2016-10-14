//
//  HomeViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/13.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var homeView: HomeView = HomeView (frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "首页"
        
        self.view.addSubview(homeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
