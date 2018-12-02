//
//  Sources.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

enum CellState {
    case collapsed
    case expanded
}

class ThreeRegistedUser: ASDisplayNode {
    
    private let oneImage: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 20, height: 20)
        node.image = UIImage(named: "ic_one_regist")
        node.cornerRadius = 10.0
        return node
    }()
    
    private let twoImage: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 20, height: 20)
        node.image = UIImage(named: "ic_two_regist")
        node.cornerRadius = 10.0
        return node
    }()
    
    private let threeImage: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.image = UIImage(named: "ic_three_regist")
        node.style.preferredSize = CGSize(width: 20, height: 20)
        node.cornerRadius = 10.0
        return node
    }()
    
    private let moreImage: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.backgroundColor = UIColor.gray.withAlphaComponent(0.375)
        node.image = UIImage(named: "ic_more_horiz_white")
        node.style.preferredSize = CGSize(width: 20, height: 20)
        node.cornerRadius = 10.0
        return node
    }()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.twoImage.style.layoutPosition = CGPoint(x: self.oneImage.style.preferredSize.width - self.oneImage.style.preferredSize.width/3, y: 0)
        
        self.threeImage.style.layoutPosition = CGPoint(x: self.oneImage.style.preferredSize.width * 2 - self.oneImage.style.preferredSize.width/1.5, y: 0)
        
        self.moreImage.style.layoutPosition = CGPoint(x: self.oneImage.style.preferredSize.width * 2, y: 0)
        
        let aboulute = ASAbsoluteLayoutSpec(sizing: ASAbsoluteLayoutSpecSizing.sizeToFit, children: [self.oneImage, self.twoImage, threeImage, moreImage])
        
        return aboulute
    }
}

class BaseCell: ASCellNode {
    
    private let baseImage: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.image = #imageLiteral(resourceName: "no_image")
        node.style.preferredSize = CGSize(width: 65.0, height: 65.0)
        node.cornerRadius = 3.0
        
        return node
    }()
    
    private let sidText: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)])
        
        return node
    }()
    
    private let snameText: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.bold)])
        return node
    }()
    
    private let languageText: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "en", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)])
        return node
    }()
    
    private let followButton: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 85, height: 30)
        node.setTitle("Follow", with: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold), with: UIColor.white, for: .normal)
        node.backgroundColor = UIColor(hexString: "#26a65b")
        node.cornerRadius = 15.0
        return node
    }()
    
    private let followedCount: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "\(Int.random(in: 0 ..< 150))", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.semibold)])
        return node
    }()
    
    private let followedsText: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Followeds", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.bold)])
        return node
    }()
    
    private let threeRegistedUser: ThreeRegistedUser = {
        let node = ThreeRegistedUser()
        
        return node
    }()
    
    private let facebookButton: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 25, height: 25)
        node.setImage(UIImage(named: "ic_facebook"), for: .normal)
        return node
    }()
    
    private let twitterButton: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 25, height: 25)
        node.setImage(UIImage(named: "ic_twitter"), for: .normal)
        return node
    }()
    
    private let explanButton: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "ic_keyboard_arrow_down"), for: .normal)
        node.style.preferredSize = CGSize(width: 18, height: 18)
        
        return node
    }()
    
    private let showChartButton: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 30)
        node.cornerRadius = 15.0
        node.setTitle("Show chart ", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
        node.backgroundColor = UIColor(hexString: "#f27935").withAlphaComponent(0.8)
        node.setImage(UIImage(named: "ic_bubble_chart_white"), for: .normal)
        node.semanticContentAttribute = .forceLeftToRight
        return node
    }()
    
    private let upOrDownChart: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "ic_arrow_drop_down_white")
        node.style.preferredSize = CGSize(width: 25, height: 25)
        return node
    }()
    
    init(source: Sources?) {
        super.init()
        
        self.baseImage.url = source?.fav_icon_url
        self.sidText.attributedText = NSAttributedString(string: source?.sid ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)])
        self.snameText.attributedText = NSAttributedString(string: source?.sname ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11.0, weight: UIFont.Weight.bold)])
        
        automaticallyManagesSubnodes = true
        selectionStyle = .none
        
        showChartButton.addTarget(self, action: #selector(showChar), forControlEvents: .touchUpInside)
    }
    
    @objc
    private func showChar() {
        showChartButton.shake()

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let baseInfosArea = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 5.0,
                                              justifyContent: .start,
                                              alignItems: .start,
                                              children: [snameText,
                                                         sidText,
                                                         languageText])
        sidText.style.maxWidth = ASDimensionMake(50.0)
        
        let _baseInforsArea = ASStackLayoutSpec(direction: .horizontal, spacing: 10.0, justifyContent: .spaceBetween, alignItems: .stretch, children: [baseInfosArea, ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity, left: CGFloat.infinity, bottom: 5, right: 20.0), child: explanButton)])
        
        _baseInforsArea.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 65 - 20, height: 20)
        
        let followedArea = ASStackLayoutSpec(direction: .vertical, spacing: 5.0, justifyContent: .start, alignItems: .center, children: [followedCount, followedsText])

        let socialButtonsArea = ASStackLayoutSpec(direction: .horizontal, spacing: 5.0, justifyContent: .center, alignItems: .end, children: [facebookButton, twitterButton])
        
        let _f = ASStackLayoutSpec(direction: .vertical, spacing: 10.0, justifyContent: .center, alignItems: .center, children: [followButton, threeRegistedUser])
        
        let _cStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5.0, justifyContent: .spaceAround, alignItems: .stretch, children: [_f, followedArea, socialButtonsArea])

        let _bStack = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .stretch, children: [_baseInforsArea, _cStack])

        let __tStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10.0, justifyContent: .start, alignItems: .stretch, children: [baseImage, _bStack])
        
        upOrDownChart.style.layoutPosition = CGPoint(x: self.showChartButton.style.preferredSize.width - 30, y: 3)
        
        let abou = ASAbsoluteLayoutSpec(sizing: .sizeToFit, children: [showChartButton, upOrDownChart])
        
        let parent = ASStackLayoutSpec(direction: .vertical, spacing: 8.0, justifyContent: .center, alignItems: .center, children: [__tStack, abou])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), child: parent)
    }
}
