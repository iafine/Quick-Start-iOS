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

typealias actionHandler = (_ action: HYAlertAction) -> Void

class HYAlertAction: NSObject {
    
    var title: String
    var style: HYAlertActionStyle
    var myHandler: actionHandler
    init(title: String, style: HYAlertActionStyle, handler: @escaping actionHandler) {
        self.title = title
        self.style = style
        self.myHandler = handler
        super.init()
    }
}

// MARK: - Public Methods
extension HYAlertAction {
}
