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
    
    var tableView: UITableView!
    
    var dataArray: Array<String> = ["带导航栏的web控制器", "不带导航栏的web控制器"]
}

// MARK: - Lifecycle
extension MeViewController {
    
    override func loadView() {
        tableView = UITableView (frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.title = "我"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "JS交互", style: .plain, target: self, action: #selector(javascriptHandler))
    }
}

extension MeViewController: UITableViewDelegate {
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
        
        let webVC: HYWebViewController = HYWebViewController ()
        webVC.requestUrl = URL (string: "https://www.baidu.com")
        switch indexPath.row {
        case 0:
            webVC.isShowNav = true
            break
        
        case 1:
            webVC.isShowNav = false
            break
            
        default:
            break
        }
        navigationController?.pushViewController(webVC, animated: true)
    }
}

extension MeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return cell
    }
}

extension MeViewController {
    @objc fileprivate func javascriptHandler() {
        let webVC: HYWebTestController = HYWebTestController ()
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
