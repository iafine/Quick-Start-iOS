//
//  HomeViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/13.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import HYAlertController

// MARK: - Class
class HomeViewController: UIViewController {

    lazy var homeView: HomeView = HomeView (frame: CGRect (x: 0, y: 0, width: Constants.Rect.ScreenWidth, height: Constants.Rect.ScreenHeight))
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect (x: 0,
                                                                 y: 0,
                                                                 width: Constants.Rect.ScreenWidth,
                                                                 height: Constants.Rect.ScreenHeight),
                                                  style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var dataArray: Array = { () -> [String] in
        let array: Array = ["Alert style without title and message",
                            "Sheet style without title and message",
                            "Alert style with title and message",
                            "Sheet style with title and message",
                            "Share style with title and message",
                            "Share style with title and message",
                            "Share style with title and message",
                            "Share style with title and message"]
        return array
    }()
}

// MARK: - LifeCycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "登录", style: .plain, target: self, action: #selector(alertTest))

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        /// 监听广告跳转
        NotificationCenter.default.addObserver(self, selector: #selector(pushAdViewController), name: Constants.Notification.DISPATCH_AD_PAGE, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 移除监听
        NotificationCenter.default.removeObserver(self)
    }
}
// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            showAlertStyle()
            break
            
        case 1:
            showSheetStyle()
            break
            
        case 2:
            showAlertStyle()
            break
            
        default:
            break
        }
    }
}

// MARK: - HYAlertControllerDemo
extension HomeViewController {
    fileprivate func showAlertStyle() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Message", style: .alert)
        let oneAction: HYAlertAction = HYAlertAction (title: "One Action", style: .normal, handler:  { (action) in
            print(action.title)
        })
        let twoAction: HYAlertAction = HYAlertAction (title: "Two Action", style: .normal, handler:  { (action) in
            print(action.title)
        })
        let threeAction: HYAlertAction = HYAlertAction (title: "Three Action", style: .destructive, handler:  { (action) in
            print(action.title)
        })
        let cancelAction: HYAlertAction = HYAlertAction (title: "Cancel Action", style: .cancel, handler:  { (action) in
            print(action.title)
        })
        alertVC.addAction(action: oneAction)
        alertVC.addAction(action: twoAction)
        alertVC.addAction(action: threeAction)
        alertVC.addAction(action: cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }

    fileprivate func showSheetStyle() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: nil, style: .actionSheet)
        let oneAction: HYAlertAction = HYAlertAction (title: "One Action", style: .normal, handler:  { (action) in
            print(action.title)
        })
        let twoAction: HYAlertAction = HYAlertAction (title: "Two Action", style: .normal, handler:  { (action) in
            print(action.title)
        })
        let threeAction: HYAlertAction = HYAlertAction (title: "Three Action", style: .destructive, handler:  { (action) in
            print(action.title)
        })
        let cancelAction: HYAlertAction = HYAlertAction (title: "Cancel Action", style: .cancel, handler:  { (action) in
            print(action.title)
        })
        alertVC.addAction(action: oneAction)
        alertVC.addAction(action: twoAction)
        alertVC.addAction(action: threeAction)
        alertVC.addAction(action: cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func showShareStyle() {
        
    }
}

// MARK: - Events
extension HomeViewController {
    /// 导航栏右侧按钮事件
    @objc fileprivate func alertTest() {
//        let alertVC: UIAlertController = UIAlertController (title: "测试", message: "测试消息", preferredStyle: .actionSheet)
//        let oneAction: UIAlertAction = UIAlertAction (title: "第一个", style: .default) { (alert) in
//            print("one")
//        }
//        let twoAction: UIAlertAction = UIAlertAction (title: "第二个", style: .destructive) { (alert) in
//            print("two")
//        }
//        let threeAction: UIAlertAction = UIAlertAction (title: "第三个", style: .cancel) { (alert) in
//            print("three")
//        }
//        alertVC.addAction(oneAction
//        )
//        alertVC.addAction(twoAction)
//        alertVC.addAction(threeAction)
//        self.present(alertVC, animated: true, completion: nil)
        
//        let alertVC: HYAlertController = HYAlertController (title: "测试", message: "消息", style: .actionSheet)
//        let testAction1: HYAlertAction = HYAlertAction (title: "支付宝", image: UIImage (named: "alipay")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction2: HYAlertAction = HYAlertAction (title: "微信", image: UIImage (named: "wechat")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction3: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        let testAction4: HYAlertAction = HYAlertAction (title: "知乎", image: UIImage (named: "zhihu")!, style: .normal) { (action) in
//            print(action.title)
//        }
//        alertVC.addAction(action: testAction1)
//        alertVC.addAction(action: testAction2)
//        alertVC.addAction(action: testAction3)
//        alertVC.addAction(action: testAction4)
//        self.present(alertVC, animated: true, completion: nil)
        LoginHelper.openLoginPage(vc: self)
    }
}

// MARK: - Notification Listen
extension HomeViewController {
    /// 广告跳转
    func pushAdViewController() {
        let adVC: AdPageViewController = AdPageViewController ()
        self.navigationController?.pushViewController(adVC, animated: true)
    }
}
