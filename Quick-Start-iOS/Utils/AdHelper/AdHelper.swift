//
//  AdHelper.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/19.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

private let ad_image_path_key: String = "AD_IMAGE_APTH"

class AdHelper: NSObject {
    
    /// 是否需要显示广告
    class func isNeedShow() -> Bool {
        if let imageName = UserDefaults.standard.string(forKey: ad_image_path_key) {
            let filePath: String = adImagePathWithImageName(imageName: imageName)!
            let isExist: Bool = isFileExistWithFilePath(filePath: filePath)
            return isExist
        }
        return  false
    }
    
    /// 广告图片目录地址
    class func adImagePath() -> String? {
        let filePath: String?
        if let imageName = UserDefaults.standard.string(forKey: ad_image_path_key) {
            filePath = adImagePathWithImageName(imageName: imageName)
            return filePath
        }
        return String()
    }
    
    /// 更新广告图片
    class func refreshAdvertisingImage() {
        // 广告地址
        let imageUrl: String = "http://img4.duitang.com/uploads/item/201204/09/20120409174006_FcVej.jpeg"
        // 获取广告图片名称
        let imageName: String = imageUrl.components(separatedBy: "/").last!
        // 判断本地是否有这张图片
        let filePath: String = adImagePathWithImageName(imageName: imageName)!
        if !isFileExistWithFilePath(filePath: filePath) {
            // 如果图片不存在，那么删除旧的广告图片，替换新的广告图片
            downloadAdImageWithUrl(imageUrl: imageUrl, imageName: imageName)
        }
    }
    
    // MARK: private methods
    
    // 判断文件是否存在
    class private func isFileExistWithFilePath(filePath: String) -> Bool {
        let fileManager: FileManager = FileManager.default
        var isDir: ObjCBool = false
        return fileManager.fileExists(atPath: filePath, isDirectory: &isDir)
    }
    
    // 广告文件目录
    class private func adImagePathWithImageName(imageName: String) -> String? {
        if !imageName.isEmpty {
            // 获取Cache目录
            let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
            // 图片文件路径
            let filePath: String = (cacheURL?.appendingPathComponent(imageName).path)!
            return filePath
        }
        return nil
    }
    
    // 下载广告图片
    class private func downloadAdImageWithUrl(imageUrl: String?, imageName: String?) {
        DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
            do {
                let data = try Data(contentsOf: URL(string: imageUrl!)!)
                let getImage = UIImage(data: data)
                let filePath: String = self.adImagePathWithImageName(imageName: imageName!)!
                let filePathUrl: URL = URL (fileURLWithPath: filePath)
                print(filePathUrl.path)
                // 删除旧图片，并将新的广告图片名称缓存起来
                do {
                    try UIImageJPEGRepresentation(getImage!, 1.0)?.write(to: filePathUrl, options: .atomicWrite)
                }catch let error as NSError {
                    print(error.localizedDescription)
                }
                self.deleteOldAdImageFile()
                
                UserDefaults.standard.set(imageName, forKey: ad_image_path_key)
                UserDefaults.standard.synchronize()
            }
            catch {
                return
            }
        }
    }
    
    // 删除旧图片
    class private func deleteOldAdImageFile() {
        if let imageName = UserDefaults.standard.string(forKey: ad_image_path_key) {
            if !imageName.isEmpty {
                let filePath: String = adImagePathWithImageName(imageName: imageName)!
                let filePathUrl: URL = URL (string: filePath)!
                try? FileManager.default.removeItem(at: filePathUrl)
            }
        }
    }
}
