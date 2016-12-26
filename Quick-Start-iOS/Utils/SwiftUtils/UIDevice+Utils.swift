//
//  UIDevice+Utils.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/12/21.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import Contacts
import EventKit

// MARK: - 设备信息
extension UIDevice {
    public var deviceName: String {
        return UIDevice.current.name
    }
    
    public var deviceUUID: String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    public var deviceModel: String {
        return UIDevice.current.model
    }
    
    public var sysVersion: String {
        return UIDevice.current.systemVersion
    }
}

// MARK: - 第三方App是否安装
extension UIDevice {
    
    /// 本机是否安装QQ。
    /// 注意：iOS9以上需要先将QQ的URL Scheme添加到白名单上，才会生效，否则始终为false。
    /// - Returns: 是否安装QQ
    public class func isInstallQQ() -> Bool {
        return isInstallApp(appScheme: "mqq")
    }
    
    /// 本机是否安装微信。
    /// 注意：iOS9以上需要先将微信的URL Scheme添加到白名单上，才会生效，否则始终为false。
    /// - Returns: 是否安装微信
    public class func isInstallWeChat() -> Bool {
        return isInstallApp(appScheme: "wechat")
    }
    
    /// 本机是否安装微博。
    /// 注意：iOS9以上需要先将微博的URL Scheme添加到白名单上，才会生效，否则始终为false。
    /// - Returns: 是否安装微博
    public class func isInstallWeibo() -> Bool {
        return isInstallApp(appScheme: "sinaweibo")
    }
    
    /// 本机是否安装某个第三方app。
    /// 注意：iOS9以上需要先将该第三方app的URL Scheme添加到白名单上，才会生效，否则始终为false。
    /// - Parameter appScheme: App Scheme
    /// - Returns: 是否安装
    public class func isInstallThirdPartyApp(appScheme: String) -> Bool {
        return isInstallApp(appScheme: appScheme)
    }
    
    fileprivate static func isInstallApp(appScheme: String) -> Bool {
        let appUrlScheme: String
        if appScheme.hasSuffix("://") {
            appUrlScheme = appScheme
        }else {
            appUrlScheme = appScheme.appending("://")
        }
        if UIApplication.shared.canOpenURL(URL (string: appUrlScheme)!) {
            return true;
        }else {
            return false;
        }
    }
}

// MARK: - App权限获取
extension UIDevice {
    /// 是否开启相册权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启相册权限
    public class func hasPhotoAuthorization() -> Bool {
        let photoAuthStatus: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        var hasPhotoAuth: Bool = false
        switch photoAuthStatus {
        case .authorized:
            hasPhotoAuth = true
            break
            
        case .denied:
            hasPhotoAuth = false
            break
            
        case .notDetermined:
            hasPhotoAuth = false
            break
            
        case .restricted:
            hasPhotoAuth = true
            break
        }
        return hasPhotoAuth
    }
    
    /// 是否开启相机权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启相机权限
    public class func hasVideoAuthorization() -> Bool {
        let videoAuthStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        var hasVideoAuth: Bool = false
        switch videoAuthStatus {
        case .authorized:
            hasVideoAuth = true
            break
            
        case .denied:
            hasVideoAuth = false
            break
            
        case .notDetermined:
            hasVideoAuth = false
            break
            
        case .restricted:
            hasVideoAuth = false
            break
        }
        return hasVideoAuth
    }
    
    /// 是否开启麦克风权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启麦克风权限
    public class func hasAudioAuthorization() -> Bool {
        let audioAuthStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
        var hasAudioAuth: Bool = false
        switch audioAuthStatus {
        case .authorized:
            hasAudioAuth = true
            break
            
        case .denied:
            hasAudioAuth = false
            break
            
        case .notDetermined:
            hasAudioAuth = false
            break
            
        case .restricted:
            hasAudioAuth = false
            break
        }
        return hasAudioAuth
    }
    
    /// 是否开启定位权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启定位权限
    public class func hasLocationAuthorization() -> Bool {
        var hasLocationAuth: Bool = CLLocationManager.locationServicesEnabled()
        if !hasLocationAuth {
           return false
        }
        let locationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        switch locationStatus {
        case .authorizedAlways:
            hasLocationAuth = true
            break
        
        case .authorizedWhenInUse:
            hasLocationAuth = true
            break
            
        case .denied:
            hasLocationAuth = false
            break
            
        case .notDetermined:
            hasLocationAuth = false
            break
            
        case .restricted:
            hasLocationAuth = false
            break
        }
        return hasLocationAuth
    }
    
    /// 是否开启通讯录权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启通讯录权限
    public class func hasContactsAuthorization() -> Bool {
        let contactsAuthStatus: CNAuthorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        var hasContactsAuth: Bool = false
        switch contactsAuthStatus {
        case .authorized:
            hasContactsAuth = true
            break
            
        case .denied:
            hasContactsAuth = false
            break
            
        case .notDetermined:
            hasContactsAuth = false
            break
            
        case .restricted:
            hasContactsAuth = false
            break
        }
        return hasContactsAuth
    }
    
    /// 是否开启日历权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启日历权限
    public class func hasEventAuthorization() -> Bool {
        let eventAuthStatus: EKAuthorizationStatus = EKEventStore.authorizationStatus(for: .event)
        var hasEventAuth: Bool = false
        switch eventAuthStatus {
        case .authorized:
            hasEventAuth = true
            break
            
        case .denied:
            hasEventAuth = false
            break
            
        case .notDetermined:
            hasEventAuth = false
            break
            
        case .restricted:
            hasEventAuth = false
            break
        }
        return hasEventAuth
    }
    
    /// 是否开启备忘录权限，iOS10以上需要在info.plist添加描述。
    ///
    /// - Returns: 是否开启备忘录权限
    public class func hasRemiderAuthorization() -> Bool {
        let remiderAuthStatus: EKAuthorizationStatus = EKEventStore.authorizationStatus(for: .reminder)
        var hasRemiderAuth: Bool = false
        switch remiderAuthStatus {
        case .authorized:
            hasRemiderAuth = true
            break
            
        case .denied:
            hasRemiderAuth = false
            break
            
        case .notDetermined:
            hasRemiderAuth = false
            break
            
        case .restricted:
            hasRemiderAuth = false
            break
        }
        return hasRemiderAuth
    }
}
