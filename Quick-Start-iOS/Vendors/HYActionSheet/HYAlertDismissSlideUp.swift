//
//  HYAlertDismissSlideUp.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYAlertDismissSlideUp: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return HY_Constants.animateDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC: HYAlertController = transitionContext.viewController(forKey: .from) as! HYAlertController
        let duration: TimeInterval = transitionDuration(using: transitionContext)
        
        // 执行动画
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseInOut,
                       animations: {
                        fromVC.dimBackgroundView.alpha = 0
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}

