//
//  ErrorPresenter.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/12/9.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

struct ErrorOptions {
    let message: String
    let messageFont: UIFont
    let messageColor: UIColor
    let backgroundColor: UIColor
    let errorIcon: UIImage
    
    init(message: String = "网络出错，轻触屏幕重新加载", messageFont: UIFont = UIFont.systemFont(ofSize: 13.0), messageColor: UIColor = UIColor.darkGray, backgroundColor: UIColor = UIColor.white, errorIcon: UIImage = UIImage (named: "error_icon")!) {
        self.message = message
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.backgroundColor = backgroundColor
        self.errorIcon = errorIcon
    }
}

protocol ErrorPresenter {
    func presentError(errorOptions: ErrorOptions)
}

extension ErrorPresenter where Self: UIView {
    func presentError(errorOptions: ErrorOptions = ErrorOptions()) {
        let errorView = defaultErrorView(errorOptions: errorOptions)
        self.addSubview(errorView)
    }
}

extension ErrorPresenter where Self: UIViewController {
    func presentError(errorOptions: ErrorOptions = ErrorOptions()) {
        let errorView = defaultErrorView(errorOptions: errorOptions)
        self.view.addSubview(errorView)
    }
}

extension ErrorPresenter {
    /// default error view
    fileprivate func defaultErrorView(errorOptions: ErrorOptions) -> UIView {
        let errorView = UIView (frame: CGRect (x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.size.width,
                                               height: UIScreen.main.bounds.size.height))
        errorView.backgroundColor = errorOptions.backgroundColor
        // add a error image and message label
        let messageLabel = UILabel()
        messageLabel.text = errorOptions.message
        messageLabel.textColor = errorOptions.messageColor
        messageLabel.font = errorOptions.messageFont
        messageLabel.sizeToFit()
        messageLabel.center = errorView.center
        
        let errorImageView = UIImageView (frame: CGRect (x: 0,
                                                         y: 0,
                                                         width: 60,
                                                        height: 60))
        errorImageView.image = errorOptions.errorIcon
        errorImageView.center = CGPoint (x: errorView.bounds.size.width / 2,
                                         y: (errorView.bounds.size.height - messageLabel.bounds.size.height - errorImageView.bounds.size.height) / 2 - 5)
        
        errorView.addSubview(errorImageView)
        errorView.addSubview(messageLabel)
        
        return errorView
    }
}

