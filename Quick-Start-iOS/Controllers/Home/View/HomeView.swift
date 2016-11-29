//
//  HomeView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Class
class HomeView: UIView {
    
    //    lazy var menuCollectionView: UICollectionView = {
    //        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout ()
    ////        collectionLayout.scrollDirection = .horizontal  // 设置视图滚动方向
    //
    //        let collectionView: UICollectionView = UICollectionView (frame: CGRect (x: 0, y: 30, width: Constants.Rect.ScreenWidth, height: 700), collectionViewLayout: collectionLayout)
    ////        collectionView.showsHorizontalScrollIndicator = false
    //        collectionView.backgroundColor = UIColor.lightGray
    //        collectionView.isPagingEnabled = true
    //        return collectionView
    //    }()
    
    lazy var shareTable: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect (x: 0,
                                                                 y: 0,
                                                                 width: Constants.Rect.ScreenWidth,
                                                                 height:Constants.Rect.ScreenHeight - Constants.Rect.tabBarHeight),
                                                  style: .plain)
        tableView.backgroundColor = UIColor.white
        //        tableView.isScrollEnabled = false
        return tableView
    }()
    
    /// 存储各个collectionView的偏移量
    var contentOffsetDictionary: NSMutableDictionary = NSMutableDictionary ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension HomeView {
    fileprivate func initUI() {
        //        self.menuCollectionView.delegate = self
        //        self.menuCollectionView.dataSource = self
        //        self.menuCollectionView.register(HYShareCollectionCell.self, forCellWithReuseIdentifier: HYShareCollectionCell.ID())
        //        self.addSubview(self.menuCollectionView)
    }
}
