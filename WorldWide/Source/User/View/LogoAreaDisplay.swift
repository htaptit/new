//
//  LogoAreaDisplay.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class LogoAreaDisplay: ASDisplayNode {
    private let logo: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 60, height: 60)
        node.backgroundColor = UIColor.white
        node.cornerRadius = 30
        node.borderWidth = 5.0
        node.borderColor = UIColor(hexString: "#5d5e72").cgColor
        node.image = UIImage(named: "ic_face")
        
        return node
    }()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .center, alignItems: .center, children: [self.logo])
    }
    
}
