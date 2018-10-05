//
//  NewViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 9/24/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class NewViewController: ASViewController<ASTableNode> {
    
    private var numberOfSection: Int = 15
    
    private var state: CellState = .collapsed
    
    init() {
        super.init(node: ASTableNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: ASTableNode.init())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        node.allowsMultipleSelection = true
        node.allowsSelectionDuringEditing = false
        
        node.view.separatorStyle = .none
        node.view.rowHeight = UITableViewAutomaticDimension
        node.view.estimatedRowHeight = 200
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func toogleSection(indexPath: IndexPath) {
        if self.state == .collapsed {
            // remove cell detail
            if self.node.numberOfRows(inSection: indexPath.section) > 1 {
                self.node.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .fade)
            }
        } else {
            // add cell detail
            self.node.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .fade)
        }
    }
    
}

extension NewViewController: ASTableDataSource, ASTableDelegate {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return self.numberOfSection
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if self.state == .collapsed {
            return 1
        }
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        if indexPath.row == 0 {
            let nodeBlock: ASCellNodeBlock = {
                return BaseCell()
            }
            
            return nodeBlock
        } else {
            let nodeBlock: ASCellNodeBlock = {
                return DetailCell()
            }
            
            return nodeBlock
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.node.deleteRows(at: [indexPath], with: .fade)
            self.node.deselectRow(at: IndexPath(row: 0, section: indexPath.section), animated: true)
            self.state = .collapsed
        } else {
            self.state = .expanded
            self.toogleSection(indexPath: indexPath)
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, didDeselectRowAt indexPath: IndexPath) {
        self.state = .collapsed
        self.toogleSection(indexPath: indexPath)
    }
}
