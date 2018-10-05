//
//  DetailCell.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/5/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class DetailCell: ASCellNode {
    
    //    private var stackNode: ASDisplayNode = ASDisplayNode()
    
    private var detailNode: Detail = {
        let node = Detail()
        
//        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 95)
        
        return node
    }()
    //
    //    private var detailNode: Detail = {
    //        let node = Detail()
    //        return node
    //    }()
    //
    //    var stackView: UIStackView?
    //
    override init() {
        super.init()
        
        //        let _tmpNode = ASDisplayNode.init { () -> UIView in
        //            let stack = UIStackView(arrangedSubviews: [ self.baseNode.view, self.detailNode.view ])
        //            stack.spacing = 0
        //            stack.axis = .vertical
        //            stack.distribution = .fillEqually
        //            stack.alignment = UIStackViewAlignment.center
        //            stack.arrangedSubviews.last?.isHidden = true
        //            self.stackView = stack
        //
        //            return stack
        //        }
        //
        //        self.stackNode = _tmpNode
        //
        //        self.addSubnode(stackNode)
        automaticallyManagesSubnodes = true
        
        self.selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: detailNode)
    }
    
    //    var state: CellState = .collapsed {
    //        didSet {
    //            toggle()
    //        }
    //    }
    
    //    private func toggle() {
    //        if stateIsCollapsed() {
    //            self.style.preferredSize.height = 95
    //        } else {
    //            self.style.preferredSize.height = 300
    //        }
    //
    //        self.transitionLayout(withAnimation: false, shouldMeasureAsync: false) {
    //            self.stackView?.arrangedSubviews.last?.isHidden = self.stateIsCollapsed()
    //        }
    //    }
    //
    //    private func stateIsCollapsed() -> Bool {
    //        return state == .collapsed
    //    }
}

