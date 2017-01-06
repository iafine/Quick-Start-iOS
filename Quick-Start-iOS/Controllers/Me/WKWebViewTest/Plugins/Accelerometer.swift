//
//  Accelerometer.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/5.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit
import CoreMotion

class Accelerometer: Plugin {
    var motionManager: CMMotionManager!
    var isRuning = false
    
    let kAccelerometerInterval: TimeInterval = 10
    let kGravitationalConstant = -9.81
    
    func getCurrentAcceleration() {
        if motionManager == nil {
            motionManager = CMMotionManager ()
        }
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = self.kAccelerometerInterval / 1000
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (data, error) in
                let dic = NSMutableDictionary ()
                dic["x"] = (data?.acceleration.x)! * self.kGravitationalConstant
                dic["y"] = (data?.acceleration.y)! * self.kGravitationalConstant
                dic["z"] = (data?.acceleration.z)! * self.kGravitationalConstant
                dic["timestamp"] = NSDate().timeIntervalSince1970
                if self.callBack(results: dic) {
                    self.motionManager.stopAccelerometerUpdates()
                }
            })
            if !self.isRuning {
                self.isRuning = true
            }
        }else {
            self.errorCallBack(errorMessage: "accelerometer not available!")
        }
        
    }
}
