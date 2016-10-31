//
//  HYAlertAction.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public enum HYAlertActionStyle : Int {
    case normal
    case cancel
    case destructive
}

typealias handler = (UIAlertAction) -> Void

class HYAlertAction: NSObject {
    
    var title: String
    var style: HYAlertActionStyle
    
    init(title: String, style: HYAlertActionStyle, handler:handler) {
        self.title = title
        self.style = style
        super.init()
    }
}

// MARK: - Public Methods
extension HYAlertAction {
}
