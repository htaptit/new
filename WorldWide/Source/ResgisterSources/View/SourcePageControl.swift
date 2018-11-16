//
//  SourcePageControl.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import AsyncDisplayKit

class SourcesPageControl: ASCellNode {
    
    var types: Types? {
        didSet {
            self.collectionNode.reloadData()
        }
    }
    
    private let collectionNode: ASCollectionNode = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        
        collectionLayout.minimumInteritemSpacing = 8
        collectionLayout.minimumLineSpacing = 8
        let node = ASCollectionNode(collectionViewLayout: collectionLayout)
        node.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        return node
    }()
    
    override init() {
        
        super.init()
        
        automaticallyManagesSubnodes = true
        
        collectionNode.dataSource = self
        collectionNode.delegate = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.collectionNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 66)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: self.collectionNode)
    }
}

extension SourcesPageControl: ASCollectionDataSource, ASCollectionDelegate {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.types?.types?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let _node = SourceCategoryNode(type: self.types?.types?[indexPath.row])
        let block: ASCellNodeBlock = {
            return _node
        }
        return block
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(CGSize(width: 50, height: 50))
    }
}
