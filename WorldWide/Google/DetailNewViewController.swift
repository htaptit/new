//
//  DetailNewViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/13/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import WebKit
import AsyncDisplayKit
import Unbox

class DetailNewViewController: ASViewController<ASTableNode> {
    var article: Article?
    
    var items: ContentNYTimes?
    
    init(article: Article?) {
        if let art = article {
            self.article = art
        }
        
        super.init(node: ASTableNode())
        self.navigationItem.title = "Detail"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.delegate = self
        node.dataSource = self
        node.view.separatorStyle = .none
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = back
        self.getContentByURL()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContentByURL() {
//        guard let article = self.article else {
//            return
//        }
//        
//        let urlString = article.url.absoluteString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
//        
//        MyApiAdap.request(target: MyApi.nytimes_crawl(url_string: urlString!), success: { (response) in
//            do {
//                let contents: ContentNYTimes = try unbox(data: response.data)
//                if let _ = self.items {
//                    self.items?.append(unboxable_objec: contents)
//                } else {
//                    self.items = contents
//                }
//                
//                self.addRowToTableNode(newArticleCount: contents.items.count)
//            } catch {
//                debugPrint("parse json error ! ")
//            }
//        }, error: { (error) in
//            debugPrint(error)
//        }) { (moya) in
//            debugPrint(moya)
//        }
    }
    
    func addRowToTableNode(newArticleCount newArticles: Int) {
        if let items = self.items?.items {
            let range = (0..<items.count)
            let indexPaths = range.map{ IndexPath(row: $0, section: 0) }
            node.insertRows(at: indexPaths, with: .none)
        }
    }
    
}
extension DetailNewViewController: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if let items = self.items?.items {
            return items.count
        }
        
        return 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let items = self.items!.items
        let nodeBlock: ASCellNodeBlock = {
            return DetailNytimeNode(item: items[indexPath.row])
        }
        
        return nodeBlock
    }
}

