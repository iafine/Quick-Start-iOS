//
//  HYAlertController.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

let identifier = "Cell"

class HYAlertController: UIViewController, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    lazy var sheetView: UITableView = {
        let tableView: UITableView = UITableView ()
        return tableView
    }()
    
    lazy var testLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = UIColor.green
        return label
    }()
    
    lazy var bgView: UIView = {
        let view: UIView = UIView ()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    // MARK: - lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        self.view.addSubview(self.bgView)
        self.view.addSubview(self.testLabel)
        self.sheetView.delegate = self
        self.sheetView.dataSource = self
        self.sheetView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        let bgTapGR: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(clickedBgViewHandler))
        self.bgView.addGestureRecognizer(bgTapGR)
        
//        self.view.addSubview(self.sheetView)
//
        initLayout()
        
    }
    
    func initLayout() {
        self.bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.testLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(120)
        }
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        cell.textLabel?.text = "测试数据"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertPresentSlideUp ()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HYAlertDismissSlideUp ()
    }
    
    // MARK: - evnets
    func clickedBgViewHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}
