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
}

// MARK: - LifeCycle
extension LocationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"

        let className: String = self.hy_name
        print("\(className)")
        let currentName: String = UIViewController.hy_currentViewControllerName()!
        print("\(currentName)")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
//        presentLoading()
        
        requestLatestNews()
    }
    
    // 网络请求，以知乎日报API为例，URL：http://news-at.zhihu.com/api/4/news/latest
    fileprivate func requestLatestNews() {
        let url = URL (string: "http://news-at.zhihu.com/api/4/news/latest")
        let request = URLRequest (url: url!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession (configuration: configuration)
        
        self.storiesArr.removeAllObjects()
        let task = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                do {
                    let responseDict: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    
                    let stories: NSArray = responseDict.object(forKey: "stories") as! NSArray
                    
                    self.storiesArr.addObjects(from: stories as! [Any])
                    // 主线程更新UI
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch{
                }
            }
        })
        task.resume()
    }
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storiesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let dic: NSDictionary = self.storiesArr.object(at: indexPath.row) as! NSDictionary
        
        cell.textLabel?.text = dic.object(forKey: "title") as! String?
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
