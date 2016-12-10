//
//  LoadingPresenter.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/12/9.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

struct LoadingOptions {
    
    let message: String
    let backgroundColor: UIColor
    let messageFont: UIFont
    let messageColor: UIColor
    let indicatorStyle: UIActivityIndicatorViewStyle
    
    init(message: String = "Loading...", backgroundColor: UIColor = UIColor.white, messageFont: UIFont = UIFont.systemFont(ofSize: 16), messageColor: UIColor = UIColor.black, indicatorStyle: UIActivityIndicatorViewStyle = .gray) {
        self.message = message
        self.backgroundColor = backgroundColor
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.indicatorStyle = indicatorStyle
    }
}

protocol LoadingPresenter {
    func presentLoading(loadingOptions: LoadingOptions)
}

extension LoadingPresenter where Self: UIView {
    func presentLoading(loadingOptions: LoadingOptions = LoadingOptions()){
        let loadingView = defaultLoadingView(loadingOptions: loadingOptions)
        self.addSubview(loadingView)
    }
}

extension LoadingPresenter where Self: UIViewController {
    func presentLoading(loadingOptions: LoadingOptions = LoadingOptions()){
        let loadingView = defaultLoadingView(loadingOptions: loadingOptions)
        self.view.addSubview(loadingView)
    }
}

extension LoadingPresenter {
    // default loading view
    fileprivate func defaultLoadingView(loadingOptions: LoadingOptions) -> UIView {
        let loadingView = UIView (frame: CGRect (x: 0,
                                                 y: 0,
                                                 width: UIScreen.main.bounds.size.width,
                                                 height: UIScreen.main.bounds.size.height))
        loadingView.backgroundColor = loadingOptions.backgroundColor
        
        // add a indicator view and message label
        let messageLabel = UILabel()
        messageLabel.text = loadingOptions.message
        messageLabel.font = loadingOptions.messageFont
        messageLabel.textColor = loadingOptions.messageColor
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        messageLabel.center = loadingView.center
        
        let indicatorView = UIActivityIndicatorView (activityIndicatorStyle: loadingOptions.indicatorStyle)
        indicatorView.frame = CGRect (x: messageLabel.frame.origin.x - indicatorView.bounds.size.width - 5,
                                      y: messageLabel.frame.origin.y,
                                      width: indicatorView.bounds.size.width,
                                      height: indicatorView.bounds.size.height)
        
        indicatorView.startAnimating()
        
        loadingView.addSubview(indicatorView)
        loadingView.addSubview(messageLabel)
        
        return loadingView
    }
}
