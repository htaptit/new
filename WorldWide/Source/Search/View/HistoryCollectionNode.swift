//
//  HistoryCollectionNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}

class _Node: ASCellNode {
    private let textNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor(hexString: "#def4e4")
        node.cornerRadius = 15.0
        node.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        node.style.minWidth = ASDimensionMake(35.0)
        node.style.minHeight = ASDimensionMake(25.0)
        return node
    }()
    
    init(text: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        textNode.setTitle(text, with: UIFont.systemFont(ofSize: 14, weight: .regular), with: nil, for: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: textNode)
    }
}

class HistoryCollectionNode: ASCellNode {
    
    private var historys: [String] = ["bitcoint", "tinhte", "genk", "conghoaxahoichunghiavietnam"]
    
    private let collection: ASCollectionNode = {
        let collectionLayout = LeftAlignedCollectionViewFlowLayout()
        
        let node = ASCollectionNode(collectionViewLayout: collectionLayout)
        node.style.maxHeight = ASDimensionMake((25 + 8 + 8) * 3)
        node.style.minWidth = ASDimensionMake(UIScreen.main.bounds.width)
        
        collectionLayout.minimumInteritemSpacing = 8
        collectionLayout.minimumLineSpacing = 8
        
        node.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        return node
    }()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        collection.dataSource = self
        collection.delegate = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: self.collection)
    }
}

extension HistoryCollectionNode: ASCollectionDataSource, ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return historys.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let text = historys[indexPath.row]
        
        let nodeBlock: ASCellNodeBlock = {
            return _Node(text: text)
        }
        
        return nodeBlock
    }
}
