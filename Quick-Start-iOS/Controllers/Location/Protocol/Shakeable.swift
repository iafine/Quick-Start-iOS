//
//  Shakeable.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/12/6.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

protocol Shakeable {
    
}

extension Shakeable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation (keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue (cgPoint: CGPoint (x: self.center.x - 4.0, y: self.center.y))
        animation.toValue = NSValue (cgPoint: CGPoint (x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
    
