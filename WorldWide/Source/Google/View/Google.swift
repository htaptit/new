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
        node.style.preferredSize = CGSize(width: 80.0, height: 80.0)
        node.contentMode = .scaleAspectFill
        node.cornerRadius = 5.0
        return node
    }()
    
    private let favoriteImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 25, height: 15)
        node.image = #imageLiteral(resourceName: "no_image")
        node.contentMode = .scaleAspectFill
        node.borderWidth = 0.2
        node.borderColor = UIColor.gray.cgColor
        node.cornerRadius = 3.0
        
        return node
    }()
    
    private let titleNode: ASTextNode
    private let subtitleNode: ASTextNode
    private let auth: ASTextNode = {
        let textNode = ASTextNode()
        textNode.maximumNumberOfLines = 2
        textNode.style.maxWidth = ASDimensionMake(UIScreen.main.bounds.width / 2)
        return textNode
    }()
    
    private let created_at: ASTextNode
    
    // MARK: - Object life cycle
    
    init(article: Article) {
        self.imageNode.url = article.urlToImage
        
        if let source = NewsSource(rawValue: article.sourceid.replacingOccurrences(of: "-", with: "_")) {
            let urlString = source.getFavoriteIconOfDomain(source: source)
            self.favoriteImageNode.url = URL(string: urlString)
        }
        
        self.titleNode = ASTextNode()
        let title = NSAttributedString(string: article.title ?? "", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        self.titleNode.attributedText = title
        
        self.subtitleNode = ASTextNode()
        let subtitle = NSAttributedString(string: article.description ?? "", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        self.subtitleNode.attributedText = subtitle
        
        let authText = NSAttributedString(string: article.author ?? article.sourcename, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        self.auth.attributedText = authText
        
        self.created_at = ASTextNode()
        if let publishedAt = article.publishedAt {
            let createdAtText = NSAttributedString(string: UnboxDateFormater.date(format: "MMM dd, H:m").string(from: publishedAt), attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
            self.created_at.attributedText = createdAtText
        }
        
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageNodeStack = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .start, alignItems: .end, children: [self.imageNode])
        let centerTT = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: imageNodeStack)
        
        let insetImageNodeStack = UIEdgeInsets(top: 2.0, left: 5.0, bottom: 2.0, right: 5.0)
        
        let titlesStack = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .stretch, children: [self.titleNode, self.subtitleNode])
        titlesStack.style.flexGrow = 1
        titlesStack.style.flexShrink = 1
        let topStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5.0, justifyContent: .spaceBetween, alignItems: .stretch, children: [titlesStack, centerTT])
        
        let favoriteImageStack = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .start, alignItems: .end, children: [self.favoriteImageNode])
        
        // bottom layout
        let authStack = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .start, alignItems: .end, children: [self.auth])
        let centerYAuthStack = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: authStack)
        
        let createdAtStack = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .start, alignItems: .end, children: [self.created_at])
        let centerYforCreateAtStack = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: createdAtStack)
        
        let leftInfoStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10.0, justifyContent: .start, alignItems: .stretch, children: [favoriteImageStack, centerYAuthStack])
        let parentInfoStack = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceBetween, alignItems: .stretch, children: [leftInfoStack, centerYforCreateAtStack])
        // end bottom layout
        
        let parentVertical = ASStackLayoutSpec.vertical()
        parentVertical.justifyContent = .spaceAround
        parentVertical.alignItems = .stretch
        
        parentVertical.children = [ASInsetLayoutSpec(insets: insetImageNodeStack, child: topStack),
//                                   ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 10.0, right: 5.0), child: titlesStack),
                                   ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0), child: parentInfoStack)]
        
        return ASInsetLayoutSpec(insets: insetImageNodeStack, child: parentVertical)
    }

}
