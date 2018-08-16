//
//  DetailNytimeNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 4/23/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class DetailNytimeNode: ASCellNode {
    private let textNode: ASTextNode
//    private var imageNode: ASNetworkImageNode
    var imageURL: String?
    
    init(item: ItemsNYTimes) {
        self.imageURL = item.imageURLString
        
        self.textNode = ASTextNode()
        let text = NSAttributedString(string: item.text, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12.0)])
        self.textNode.attributedText = text
        
        super.init()
        
        self.automaticallyManagesSubnodes =  true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let vertical = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .start, children: [self.textNode])
        if let urlString = self.imageURL {
            if !urlString.isEmpty {
                let imageNode = ASNetworkImageNode()
                imageNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 250.0)
                imageNode.contentMode = .scaleAspectFill
                imageNode.url = URL(string: urlString)!
                vertical.children?.append(imageNode)
            }
        }
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0), child: vertical)
    }
}
