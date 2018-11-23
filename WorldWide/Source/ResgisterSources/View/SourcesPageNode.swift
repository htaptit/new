//
//  SourcesPageNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import AsyncDisplayKit

class SourcesPageNode: ASCellNode {
    
    private var dsTypes: Types?
    
    private var asPageNode: ASPagerNode = {
        let layout = ASPagerFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let node = ASPagerNode(collectionViewLayout: layout)
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 66.0 - 115.0)
        return node
    }()
    
    init(dsTypes: Types?) {
        super.init()
        self.dsTypes = dsTypes
        asPageNode.setDataSource(self)
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: asPageNode)
    }
}

extension SourcesPageNode: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return self.dsTypes?.types?.count ?? 0
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            return NewViewController(types: self.dsTypes?.types?[index])
        }, didLoad: nil)
        
        node.style.preferredSize = asPageNode.bounds.size
        
        return node
    }
}
