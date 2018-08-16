//
//  Google.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/15/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//
import Foundation
import AsyncDisplayKit

class Google: ASCellNode {
    // MARK: - Variables
    
    private let imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.image = #imageLiteral(resourceName: "no_image")
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 200.0)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let titleNode: ASTextNode
    private let subtitleNode: ASTextNode
    private let auth: ASTextNode
    private let created_at: ASTextNode
    
    // MARK: - Object life cycle
    
    init(article: Article) {
        self.imageNode.url = article.urlToImage
        
        self.titleNode = ASTextNode()
        let title = NSAttributedString(string: article.title ?? "", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)])
        self.titleNode.attributedText = title
        
        self.subtitleNode = ASTextNode()
        let subtitle = NSAttributedString(string: article.description ?? "", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)])
        self.subtitleNode.attributedText = subtitle
        
        self.auth = ASTextNode()
        let authText = NSAttributedString(string: article.author ?? "Google News", attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        self.auth.attributedText = authText
        
        
        self.created_at = ASTextNode()
        
        if let publishedAt = article.publishedAt {
            let createdAtText = NSAttributedString(string: UnboxDateFormater.date(format: "yyyy/mm/dd . hh:mm").string(from: publishedAt), attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
            self.created_at.attributedText = createdAtText
        }
        
        super.init()
        
        self.automaticallyManagesSubnodes = true
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let _topVertical = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .center, children: [self.imageNode])
        let insetTopVertical = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        
        let _centerVertical = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .end, alignItems: .start, children: [self.titleNode, self.subtitleNode])
        let insetBottonVertical = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 10.0, right: 5.0)
        
        
        self.auth.maximumNumberOfLines = 2
        self.auth.style.maxWidth = ASDimensionMake(UIScreen.main.bounds.width / 2)
        let _bottomHorizontal = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .start, alignItems: .end, children: [self.auth])
        
        let __bottomHorizontal = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .start, alignItems: .end, children: [self.created_at])
        let _centerX__bottonHorizontal = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: __bottomHorizontal)
        
        let _parentHorizontal = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceBetween, alignItems: .stretch, children: [_bottomHorizontal, _centerX__bottonHorizontal])
        
        
        
        let parentVertical = ASStackLayoutSpec.vertical()
        parentVertical.justifyContent = .spaceAround
        parentVertical.alignItems = .stretch
        
        parentVertical.children = [ASInsetLayoutSpec(insets: insetTopVertical, child: _topVertical),
                                   ASInsetLayoutSpec(insets: insetBottonVertical, child: _centerVertical),
                                   ASInsetLayoutSpec(insets: insetBottonVertical, child: _parentHorizontal)]
        
        return ASInsetLayoutSpec(insets: insetTopVertical, child: parentVertical)
    }

}
