//
//  HYNavigationController.swift
//  Quick-Start-iOS (自定义导航栏)
//
//  Created by work on 2016/10/23.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYNavigationController: UINavigationController {

    private var vc: UIViewController
    private var imageName: String
    private var selectedImageName: String
    
    // MARk: - lifecycle
    init(vc: UIViewController, title: NSString, imageName: NSString, selectedImageName: NSString) {
        self.vc = vc
        self.imageName = imageName as String
        self.selectedImageName = selectedImageName as String
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title as String
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - private methods
    private func initUI() {
        self.tabBarItem.title = self.title
        self.tabBarItem.image = UIImage (named: imageName)
        self.tabBarItem.selectedImage = UIImage (named: selectedImageName)
        self.navigationBar.isTranslucent = false    // 取消导航栏默认透明效果
        self.viewControllers = [self.vc]
        
        setupNavigationBarAttributes()
    }
    
    private func setupNavigationBarAttributes() {
        UINavigationBar.appearance().barTintColor = UIColor (red: 146/255, green: 185/255, blue: 74/255, alpha: 1.0)    // 背景颜色
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white] // 文字颜色
    }
}
