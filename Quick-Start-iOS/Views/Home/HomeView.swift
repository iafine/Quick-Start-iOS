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
        
        self.shareTable.dataSource = self
        self.shareTable.delegate = self
        self.addSubview(self.shareTable)
    }
}

// MARK: - UITableViewDataSource
extension HomeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HYShareTableViewCell = HYShareTableViewCell.cellWithTableView(tableView: tableView)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HYShareTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shareCell: HYShareTableViewCell = cell as! HYShareTableViewCell
        shareCell.setCollectionViewDataSourceDelegate(collectionDataSource: self, collectionDelegate: self, indexPath: indexPath as NSIndexPath)
        
        let index: Int = shareCell.collectionView.tag
        if let horizontalOffset: CGFloat = self.contentOffsetDictionary.object(forKey: index) as? CGFloat {
            shareCell.collectionView.contentOffset = CGPoint (x: horizontalOffset, y: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let shareCell: HYShareTableViewCell = cell as! HYShareTableViewCell
        let index: Int = shareCell.collectionView.tag
        let horizontalOffset: CGFloat = shareCell.collectionView.contentOffset.x
        self.contentOffsetDictionary.setObject(horizontalOffset, forKey: index as NSCopying)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource
extension HomeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HYShareCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYShareCollectionCell.ID(), for: indexPath) as! HYShareCollectionCell
        cell.cellIcon.image = UIImage (named: "qq")
        cell.titleView.text = "测试"
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return HYShareCollectionCell.cellSize()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return HYShareCollectionCell.cellInset()
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
}

// MARK: - Private Methods
extension HomeView {
    /// 随机颜色值
    fileprivate func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}
