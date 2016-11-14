//
//  HYFPSLabel.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/11/14.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYFPSLabel: UILabel {
    
    fileprivate var link: CADisplayLink = CADisplayLink ()
    fileprivate var count: UInt = 0
    fileprivate var lastTime: TimeInterval = TimeInterval ()
    fileprivate var subFont: UIFont = UIFont ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.textAlignment = .center
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor (white: 0.0, alpha: 0.7)
        self.font = UIFont (name: "Menlo", size: 14)
        self.subFont = UIFont (name: "Menlo", size: 8)!
        
        self.link = CADisplayLink (target: self, selector: #selector (tick(link:)))
        self.link .add(to: RunLoop.main, forMode: .commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return HYFPSLabel.defaultSize
    }
    
    deinit {
        self.link.invalidate()
    }
}

// MARK: - Public Methods
extension HYFPSLabel {
    open func showFPS() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(self)
    }
}

// MARK: - Events
extension HYFPSLabel {
    @objc fileprivate func tick(link: CADisplayLink) {
        if self.lastTime == 0 {
            self.lastTime = link.timestamp
            return
        }
        self.count += 1
        let delta: TimeInterval = link.timestamp - lastTime
        if delta < 1 {
            return
        }
        self.lastTime = link.timestamp
        let fps: Float = Float (self.count) / Float (delta)
        self.count = 0
        
        let progress: CGFloat = CGFloat (fps / 60.0)
        let color: UIColor = UIColor (hue: 0.27 * (progress - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        let text: NSMutableAttributedString = NSMutableAttributedString (string: "\(round(fps)) FPS")
        text.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, text.length - 3))
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(text.length - 3, 3))
        text.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, text.length))
        text.addAttribute(NSFontAttributeName, value: self.subFont, range: NSMakeRange(text.length - 3, 3))
        
        self.attributedText = text;
    }
}

// MARK: - Constants
extension HYFPSLabel {
    static let defaultSize: CGSize = CGSize (width: 65, height: 20)
}
