//
//  UIApplication.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/3/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
