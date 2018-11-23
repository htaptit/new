//
//  SplashViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/22/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SplashViewController: ASViewController<ASDisplayNode> {
    
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    init() {
        super.init(node: ASDisplayNode())
        
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
