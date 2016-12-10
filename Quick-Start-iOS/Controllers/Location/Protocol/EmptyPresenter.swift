//
//  EmptyPresenter.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/12/10.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

struct EmptyOptions {
    let message: String
    let messageFont: UIFont
    let messageColor: UIColor
    let backgroundColor: UIColor
    
    init(message: String = "暂无数据", messageFont: UIFont = UIFont.systemFont(ofSize: 16), messageColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.white) {
        self.message = message
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.backgroundColor = backgroundColor
    }
}

protocol EmptyPresenter {
    func presentEmpty(emptyOptions: EmptyOptions)
}

extension EmptyPresenter where Self: UIView {
    func presentEmpty(emptyOptions: EmptyOptions = EmptyOptions()) {
        let emptyView = defaultEmptyView(emptyOptions: emptyOptions)
        self.addSubview(emptyView)
    }
}

extension EmptyPresenter where Self: UIViewController {
    func presentEmpty(emptyOptions: EmptyOptions = EmptyOptions()) {
        let emptyView = defaultEmptyView(emptyOptions: emptyOptions)
        self.view.addSubview(emptyView)
    }
}

extension EmptyPresenter {
    // default empty view
    fileprivate func defaultEmptyView(emptyOptions: EmptyOptions) -> UIView {
        let emptyView = UIView (frame: CGRect (x: 0,
                                                 y: 0,
                                                 width: UIScreen.main.bounds.size.width,
                                                 height: UIScreen.main.bounds.size.height))
        emptyView.backgroundColor = emptyOptions.backgroundColor
        
        // add a message label
        let messageLabel = UILabel()
        messageLabel.text = emptyOptions.message
        messageLabel.font = emptyOptions.messageFont
        messageLabel.textColor = emptyOptions.messageColor
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        messageLabel.center = emptyView.center

        emptyView.addSubview(messageLabel)
        
        return emptyView
    }
}
