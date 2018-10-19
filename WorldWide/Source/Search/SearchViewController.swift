//
//  SearchViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Unbox

class SearchViewController: ASViewController<ASTableNode> {
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    private var topHeadLines: GArticles?
    
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
        
        loadSearchBar()
        
        fetchNewBatchWidthContext(nil)
    }
    
    private func loadSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        searchBar.setShowsCancelButton(true, animated: true)
        
        searchBar.layer.cornerRadius = 10.0
        
        searchBar.delegate = self
        
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.red]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        navigationItem.titleView = searchBar
    }
    
    func fetchNewBatchWidthContext(_ context: ASBatchContext?) {
        GoogleApiAdap.request(target: .top_headlines(query: nil,
                                                  sources: [.google_news],
                                                  domains: nil,
                                                  from: nil, to: nil,
                                                  language: nil, sortBy: nil,
                                                  pageSize: nil,
                                                  page: nil), success: { (res) in
                                                    DispatchQueue.main.async {
                                                        do {
                                                            let top: GArticles = try unbox(data: res.data)

                                                            if let _ = self.topHeadLines {
                                                                self.topHeadLines!.append(unboxable_objec: top)
                                                            } else {
                                                                self.topHeadLines = top
                                                            }
                                                            self.addRowsIntoTableNode(newTopCount: top.articles.count)
                                                        } catch {
                                                            debugPrint("parse json error ! ")
                                                        }
                                                    }
                                                    context?.completeBatchFetching(true)
        }, error: { (error) in
            debugPrint(error.localizedDescription)
            if let _ = context { context!.completeBatchFetching(true) }
        }) { (moya) in
            debugPrint(moya)
            if let _ = context { context!.completeBatchFetching(true) }
        }
    }
    
    func addRowsIntoTableNode(newTopCount newTops: Int) {
        guard let articles = self.topHeadLines?.articles else {  return }
        let indexRange = (articles.count - newTops..<articles.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 2) }
        self.node.insertRows(at: indexPaths, with: .none)
    }
}

extension SearchViewController: ASTableDataSource, ASTableDelegate {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        default:
            return self.topHeadLines?.articles.count ?? 0
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        if indexPath.section == 2 {
            let nodeBlock: ASCellNodeBlock = {
                guard let article = self.topHeadLines?.articles[indexPath.row] else {
                    return ASCellNode()
                }
                
                return HistoryNode(article: article)
            }
            
            return nodeBlock
        } else {
            let nodeBlock: ASCellNodeBlock = {
                return HistoryCollectionNode()
            }
            
            return nodeBlock
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25.0))
        headerView.backgroundColor = UIColor(hexString: "#d4f4e4").withAlphaComponent(0.5)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .thin)
        
        switch section {
        case 0:
            label.text =  "History"
        case 1:
            label.text =  "Most searched"
        default:
            label.text =  "Top Headline"
        }
        
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = #imageLiteral(resourceName: "icn_added")
        
        headerView.addSubview(imageV)
        headerView.addSubview(label)
        
        imageV.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10.0).isActive = true
        imageV.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        imageV.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        label.leftAnchor.constraint(equalTo: imageV.rightAnchor, constant: 10.0).isActive = true
        label.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true

        return headerView
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
