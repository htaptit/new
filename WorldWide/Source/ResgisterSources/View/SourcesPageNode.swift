//
//  SourcesPageNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import AsyncDisplayKit

class SourcesPageNode: ASCellNode {
    
    private var asPageNode: ASPagerNode = {
        let layout = ASPagerFlowLayout()
        layout.scrollDirection = .horizontal
        
        let node = ASPagerNode(collectionViewLayout: layout)
        return node
    }()
    
    override init() {
        super.init()
        asPageNode.setDataSource(self)
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: asPageNode)
    }
}

extension SourcesPageNode: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return 2
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            return NewViewController()
        }, didLoad: nil)
        return node
    }
}
