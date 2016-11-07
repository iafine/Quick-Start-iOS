//
//  HYAlertPresentSlideUp.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/25.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

class HYAlertPresentSlideUp: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return HY_Constants.presentAnimateDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC: HYAlertController = transitionContext.viewController(forKey: .to) as! HYAlertController
        toVC.dimBackgroundView.alpha = 0
        let containerView: UIView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        let duration: TimeInterval = transitionDuration(using: transitionContext)
        
        // 执行动画
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
            toVC.dimBackgroundView.alpha = 1
            if toVC.alertStyle == .actionSheet {
                toVC.sheetView.transform = CGAffineTransform(translationX: 0, y: -toVC.alertHeight)
            }else if toVC.alertStyle == .shareSheet {
                toVC.shareView.transform = CGAffineTransform(translationX: 0, y: -toVC.alertHeight)
            }else {
            }
        }, completion: { (finished) in
            transitionContext.completeTransition(true)
        })
    }
}
