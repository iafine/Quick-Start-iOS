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
    
    lazy var menuCollectionView: UICollectionView = {
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout ()
//        collectionLayout.scrollDirection = .horizontal  // 设置视图滚动方向
        
        let collectionView: UICollectionView = UICollectionView (frame: CGRect (x: 0, y: 30, width: Constants.Rect.ScreenWidth, height: 100), collectionViewLayout: collectionLayout)
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
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
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.register(HYShareCollectionCell.self, forCellWithReuseIdentifier: HYShareCollectionCell.ID())
        self.addSubview(self.menuCollectionView)
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
        cell.titleLabel.text = "测试"
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HYShareCollectionCell.cellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return HYShareCollectionCell.cellInset()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
}
