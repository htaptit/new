//
//  SourceImage.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SourcesImageNode: ASCellNode {
    private let nameNode: ASTextNode = {
        let node = ASTextNode()
        
        return node
    }()
    
    private let photoNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.image = #imageLiteral(resourceName: "no_image")
        node.contentMode = .scaleAspectFill
        node.clipsToBounds = true
        node.cornerRadius = 5.0
        return node
    }()
    
    private let registerIcoNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "icn_added")
        
        node.cornerRadius = 20
        node.borderWidth = 4
        node.borderColor = UIColor.white.cgColor
        
        return node
    }()
    
    private let countRegisteredNode: ASButtonNode = {
        let node = ASButtonNode()
        
        node.backgroundColor = .red
        node.cornerRadius = 3
        return node
    }()
    
    init(surl: URL?) {
        super.init()
        
        self.photoNode.url = surl
        automaticallyManagesSubnodes = true
        
        self.nameNode.attributedText = NSAttributedString(string: "The new york times")
        self.countRegisteredNode.setTitle("2k actived", with: UIFont.systemFont(ofSize: 10.0, weight: .bold), with: nil, for: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.photoNode.style.preferredSize = CGSize(width: ((UIScreen.main.bounds.width) / 3) - 32, height: ((UIScreen.main.bounds.width) / 3) - 32)
        self.photoNode.style.layoutPosition = CGPoint(x: 0, y: 8)
        
        self.registerIcoNode.style.preferredSize = CGSize(width: 40, height: 40)
        self.registerIcoNode.style.layoutPosition = CGPoint(x: ((UIScreen.main.bounds.width) / 3) - 32 - 20, y: 0)
        
        self.countRegisteredNode.style.preferredSize = CGSize(width: 60, height: 12)
        self.countRegisteredNode.style.layoutPosition = CGPoint(x: ((UIScreen.main.bounds.width) / 3) - 32 * 2.5, y: (((UIScreen.main.bounds.width) / 3) - 32) / 1.2)
        
        let absoluteSepec = ASAbsoluteLayoutSpec(sizing: .sizeToFit, children: [self.photoNode, self.registerIcoNode, self.countRegisteredNode])
        
        let spec = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .notSet, children: [
            absoluteSepec, nameNode
            ])
        
        return spec
    }
    
    override func didLoad() {
        super.didLoad()
    }
}
