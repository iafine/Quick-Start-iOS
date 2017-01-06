//
//  Console.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/4.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit

class Console: Plugin {
    func log() {
        if let str = self.data {
            print(str)
        }
    }
}
