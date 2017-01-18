//
//  LocationViewController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/24.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import CoreTelephony

// MARK: - Class
class LocationViewController: UIViewController, LoadingPresenter, ErrorPresenter, EmptyPresenter {
    lazy var tableView: UITableView =  {
        let tableView: UITableView = UITableView (frame: CGRect (x: 0,
                                                                 y: 0,
                                                                 width: Constants.Rect.ScreenWidth,
                                                                 height: Constants.Rect.ScreenHeight - Constants.Rect.tabBarHeight),
                                                  style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // 存储展示数据数组
    var storiesArr: NSMutableArray = NSMutableArray ()
    
    // keychain
//    let keychainHelper: HYKeychainHelper = HYKeychainHelper (service: "HYAppService", account: nil, accessGroup: nil)
    
    // keychain value
    var keychainKeyArray = Array<String> ()
    var keychainValueArray = Array<AnyObject> ()
}

// MARK: - LifeCycle
extension LocationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (barButtonSystemItem: .add, target: self, action: #selector (clickedKeychainAddHandler))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
//        presentLoading()
        
//        requestLatestNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 查询keychain数据
        do {
//            let results: Dictionary<String, AnyObject> = try keychainHelper.queryItems()
//            if results.values.count > 0 {
//            }
        }
        catch {
            fatalError("Error fetching password items - \(error)")
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = keychainValue["test"] as! String?
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
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
    }
}

// MARK: - Events
extension LocationViewController {
    func clickedKeychainAddHandler() {
        do {
//            try keychainHelper.saveItem(value: "hyyy" as AnyObject, withKey: "name")
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
}
