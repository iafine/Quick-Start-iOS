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
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC: HYAlertController = transitionContext.viewController(forKey: .to) as! HYAlertController
        toVC.view.alpha = 0
        let containerView: UIView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        let duration: TimeInterval = transitionDuration(using: transitionContext)
        
        // 执行动画
        UIView .animate(withDuration: duration,
                        delay: 0,
                        options: .curveEaseInOut,
                        animations: {
                            toVC.view.alpha = 0.3
            }) { (finished) in
                transitionContext.completeTransition(true)
        }
    }
}
