//
//  SroucesViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RxSwift

class SourcesViewController: ASViewController<ASTableNode> {
    private var dsTypes: Types?
    
    private var bag = DisposeBag()
    
    init() {
        super.init(node: ASTableNode())
        node.dataSource = self
        node.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sources"
    }
    
    func fetch(_ context: ASBatchContext?) {
        WWService.getSourceRelationType()
            .subscribe(onNext: { (types) in
                
                if let _ = self.dsTypes {
                    
                } else {
                    self.dsTypes = types
                }
                
                self.node.reloadData()
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
    }
    
//    func addRowsIntoTableNode() {
//        guard let types = self.dsTypes?.types else { return }
//        let indexRange = 0..<types.count
//        let indexPaths = indexRange.map { IndexPath(row: 0, section: $0) }
//        self.node.insertRows(at: indexPaths, with: .none)
//    }
}

extension SourcesViewController: ASTableDataSource, ASTableDelegate {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        if indexPath.section == 1 {
            let block: ASCellNodeBlock = {
                let _node = SourcesPageNode()
                _node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 66.0 - 115.0)
                return _node
            }
            
            return block
        } else {
            let block: ASCellNodeBlock = {
                let _node = SourcesPageControl()
                _node.types = self.dsTypes
                return _node
            }
            
            return block
        }
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.fetch(context)
    }
}
