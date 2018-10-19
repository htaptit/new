//
//  SroucesViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SourcesViewController: ASViewController<ASTableNode> {
    private let allSourceCase: [NewsSource] = NewsSource.allValues
    
    init() {
        super.init(node: ASTableNode())
        node.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sources"
    }
}

extension SourcesViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let _node = SourcesNode()
        _node.style.preferredSize = CGSize(width: 120, height: 120)
        
        let block: ASCellNodeBlock = {
            return _node
        }
        
        return block
    }
}
