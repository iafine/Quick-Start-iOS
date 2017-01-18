//
//  HYKeychainHelper.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/18.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import Foundation

struct HYKeychainHelper {
    
    static func password(service: String, account: String, accessGroup: String? = nil) -> String {
        return ""
    }
    
    static func passwordData(service: String, account: String, accessGroup: String? = nil) -> Data {
        return Data()
    }
    
    static func deletePassword(service: String, account: String, accessGroup: String? = nil) -> Bool {
        return false
    }
    
    static func set(password: String, service: String, account: String, accessGroup: String? = nil) -> Bool {
        return false
    }
    
    static func set(passwordData: Data, service: String, account: String, accessGroup: String? = nil) -> Bool {
        return false
    }
    
    static func allAccount() -> Array<[String : AnyObject]> {
        return Array<[String : AnyObject]> ()
    }
    
    static func accounts(forService: String) -> Array<[String : AnyObject]> {
        return Array<[String : AnyObject]> ()
    }
}
