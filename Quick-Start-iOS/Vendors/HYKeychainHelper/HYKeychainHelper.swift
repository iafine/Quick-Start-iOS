//
//  HYKeychainHelper.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/16.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit

enum KeychainError: Error {
    case itemNotFound
    case unexpectedItemData
    case unhandledError(status: OSStatus)
}

struct HYKeychainHelper {
    
    let service: String
    let accessGroup: String?
    
    init(service: String, account: String? = nil, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // add
    func saveItem(value: AnyObject, withKey: String) throws {
        // Encode the password into an Data object.
        let dic: [String: AnyObject] = [withKey : value]
        let encodeDic: Data = NSKeyedArchiver.archivedData(withRootObject: dic)
        
        do {
            // 检查keychain里面是否存在，如果存在，则更新
            try _ = queryItems()
            
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodeDic as AnyObject?
            let query = HYKeychainHelper.keychainQuery(withService: service, account: nil, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            guard status == noErr else {
                throw KeychainError.unhandledError(status: status)
            }
        } catch KeychainError.itemNotFound {
            // 不存在的话，添加到keychain中
            var newItem = HYKeychainHelper.keychainQuery(withService: service, account: nil, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodeDic as AnyObject?
            
            let status = SecItemAdd(newItem as CFDictionary, nil)
            guard status == noErr else {
                throw KeychainError.unhandledError(status: status)
            }
        }
    }
    
    func queryItems() throws -> Dictionary<String, AnyObject> {
        var query = HYKeychainHelper.keychainQuery(withService: service, account: nil, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var quertResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &quertResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }
        
        // 解析成词典
        guard let existItem = quertResult as? [String : AnyObject],
            let itemData = existItem[kSecValueData as String] as? Data,
            let decodeDic = NSKeyedUnarchiver.unarchiveObject(with: itemData) as? Dictionary<String, AnyObject> else {
            throw KeychainError.unexpectedItemData
        }
        return decodeDic
    }
}

// MARK: - Private Methods
extension HYKeychainHelper {
    fileprivate static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
