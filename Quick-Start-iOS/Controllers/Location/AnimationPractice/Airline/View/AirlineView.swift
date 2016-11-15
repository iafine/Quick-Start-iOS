//
//  AirlineView.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class AirlineView: UIView {
    lazy var bgImageView: UIImageView = {
        let imageView: UIImageView = UIImageView ()
        imageView.image = UIImage (named: "bg-snowy")
        return imageView
    }()
    
    lazy var flightLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textColor = UIColor.white
        label.font = UIFont .systemFont(ofSize: 18)
        label.text = "Flight"
        label.textAlignment = .center
        return label
    }()
    
    lazy var gateLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textColor = UIColor.white
        label.text = "Gate"
        label.font = UIFont .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var flightValueLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textColor = UIColor.white
        label.font = UIFont .systemFont(ofSize: 25)
        label.text = "AE 1107"
        label.textAlignment = .center
        return label
    }()
    
    lazy var gateValueLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textColor = UIColor.white
        label.font = UIFont .systemFont(ofSize: 25)
        label.text = "045"
        label.textAlignment = .center
        return label
    }()
    
    lazy var startLocationLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.text = "CDG"
        label.textColor = UIColor (red: 254.0 / 255.0, green: 214.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
        return label
    }()
    
    lazy var planeImageView: UIImageView = {
        let imageView: UIImageView = UIImageView ()
        imageView.image = UIImage (named: "plane")
        return imageView
    }()
    
    lazy var endLocationLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.text = "FCO"
        label.textColor = UIColor (red: 254.0 / 255.0, green: 214.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
        return label
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView: UIImageView = UIImageView ()
        imageView.image = UIImage (named: "banner")
        return imageView
    }()
    
    lazy var statusLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.text = "Boarding"
        label.textColor = UIColor (red: 218.0 / 255.0, green: 76.0 / 255.0, blue: 6.0 / 255.0, alpha: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LiefCycle
extension AirlineView {
    fileprivate func initUI() {
        self.addSubview(self.bgImageView)
        self.addSubview(self.flightLabel)
        self.addSubview(self.gateLabel)
        self.addSubview(self.flightValueLabel)
        self.addSubview(self.gateValueLabel)
        self.addSubview(self.startLocationLabel)
        self.addSubview(self.planeImageView)
        self.addSubview(self.endLocationLabel)
        self.addSubview(self.statusImageView)
        self.addSubview(self.statusLabel)
    }
    
    fileprivate func initLayout() {
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        self.flightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(42)
            make.top.equalTo(self.snp.top).offset(90)
            make.size.equalTo(CGSize (width: 65, height: 22))
        }
        
        self.gateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-42)
            make.top.equalTo(self.snp.top).offset(90)
            make.size.equalTo(CGSize (width: 65, height: 22))
        }
        
        self.flightValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(23)
            make.top.equalTo(self.flightLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize (width: 109, height: 22))
        }
        
        self.gateValueLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-23)
            make.top.equalTo(self.gateLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize (width: 109, height: 22))
        }
        
        self.startLocationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(35)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize (width: 90, height: 44))
        }
        
        self.planeImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize (width: 88, height: 35))
        }
        
        self.endLocationLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-35)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize (width: 90, height: 44))
        }
        
        self.statusImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.planeImageView.snp.bottom).offset(150)
            make.size.equalTo(CGSize (width: 191, height: 47))
        }
        self.statusLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.statusImageView.snp.centerX)
            make.centerY.equalTo(self.statusImageView.snp.centerY)
            make.size.equalTo(CGSize (width: 116, height: 36))
        }
    }
}

// MARK: - Animation
extension AirlineView {
    func fadeImageView(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            imageView.image = toImage
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.bgImageView.alpha = showEffects ? 1.0 : 0.0
        }, completion: nil)
    }
}
