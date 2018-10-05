//
//  Detail.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//
import UIKit
import AsyncDisplayKit

class Detail: ASDisplayNode {
    
    // TWITTER INFOMATION
    private let twitterImage: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "no_image")
        node.style.preferredSize = CGSize(width: 50.0, height: 25.0)
        node.cornerRadius = 5.0
        
        return node
    }()
    
    private let twFollowingLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Following : ")
        return node
    }()
    
    private let twFollowingNumber: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "30")
        return node
    }()
    
    private let twFollowerLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Followers : ")
        return node
    }()
    
    private let twFollowerNumber: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "50")
        return node
    }()
    
    private let twTweetLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Tweets : ")
        return node
    }()
    
    private let twTweetNumber: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "50")
        return node
    }()
    // END TWITTER
    
    // FACEBOOK INFOMATIONS
    private let facebookImage: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "no_image")
        node.style.preferredSize = CGSize(width: 50.0, height: 25.0)
        node.cornerRadius = 5.0
        
        return node
    }()
    
    private let fbFollowingLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Following : ")
        return node
    }()
    
    private let fbFollowingNumber: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "30")
        return node
    }()
    
    private let fbLikeLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Like : ")
        return node
    }()
    
    private let fbLikeNumber: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "30")
        return node
    }()
    // END FACEBOOK
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.backgroundColor = .gray
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // TWITTER AREA
        let followingTwArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .center, children: [twFollowingLabel, twFollowingNumber])
        let followerTwArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .center, children: [twFollowerLabel, twFollowerNumber])
        let tweetTwArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .center, children: [twTweetLabel, twTweetNumber])
        
        let informationTwArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .stretch, children: [followingTwArea, followerTwArea, tweetTwArea])
        informationTwArea.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 20.0)
        
        let _twArea = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .start,
                                        children: [ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), child: twitterImage), informationTwArea])
        
        // END TWITTER AREA
        
        
        // FACEBOOK AREA
        let followingFbArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .center, children: [fbFollowingLabel, fbFollowingNumber])
        let likeFbArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .center, children: [fbLikeLabel, fbLikeNumber])
        
        let informationFbArea = ASStackLayoutSpec(direction: .horizontal, spacing: 2.0, justifyContent: .spaceAround, alignItems: .stretch, children: [followingFbArea, likeFbArea])
        informationFbArea.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 20.0)
        
        let _fbArea = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .start,
                                        children: [ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), child: facebookImage), informationFbArea])
        
        // END FACEBOOK AREA
        
        return ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .start,
                                 children: [_twArea, _fbArea])
    }
    
}
