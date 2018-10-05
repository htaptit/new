//
//  ASDisPlayNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/3/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import AsyncDisplayKit
import WebKit

extension ASDisplayNode {
    convenience init(url: URL) {
        self.init { () -> UIView in
            let node = WKWebView()
            node.load(URLRequest(url: url))
            return node
        }
    }
}

