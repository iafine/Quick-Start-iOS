//
//  HYWebHelper.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/12.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit
import WebKit

extension UIApplication {
    public class func hyScreenCapture(_ completionHandler: (UIImage?) -> Void) {
        let screenWindow = UIApplication.shared.keyWindow
        UIGraphicsBeginImageContext((screenWindow?.bounds.size)!)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.translateBy(x: -(screenWindow?.frame.origin.x)!, y: -(screenWindow?.frame.origin.y)!)
        
        screenWindow?.layer.render(in: context!)
        
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        context?.restoreGState()
        UIGraphicsEndImageContext()
        
        completionHandler(capturedImage)
    }
    
}
