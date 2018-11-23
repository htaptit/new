//
//  SearchViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RxSwift

class SearchViewController: ASViewController<ASTableNode> {
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    private var bag = DisposeBag()
    
    private var page: Int = 0
    
    private var gHeadLines: GArticles?
    
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
        WWService.getHeadLinesByCountry(country: "us", page: self.page)
            .subscribe(onNext: { (result) in
                if let _ = self.gHeadLines {
                    
                } else {
                    self.gHeadLines = result
                    self.addRowsIntoTableNode(newTopCount: result.articles?.count ?? 0)
                }
            }, onError: { (error) in
                debugPrint(error)
                context?.completeBatchFetching(true)
            }, onCompleted: {
                context?.completeBatchFetching(true)
                self.page = self.page + 1
            }) {
                context?.completeBatchFetching(true)
        }.disposed(by: self.bag)
    }
    
    func addRowsIntoTableNode(newTopCount newTops: Int) {
        guard let articles = self.gHeadLines?.articles else {  return }
        let indexRange = (articles.count - newTops..<articles.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 2) }
        self.node.insertRows(at: indexPaths, with: .none)
    }
}

extension SearchViewController: ASTableDataSource, ASTableDelegate {
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.fetchNewBatchWidthContext(context)
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        default:
            return self.gHeadLines?.articles?.count ?? 0
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        if indexPath.section == 2 {
            let nodeBlock: ASCellNodeBlock = {
                guard let article = self.gHeadLines?.articles?[indexPath.row] else {
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
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rHeader = UIView()
        let headerView = UIView(frame: CGRect(x: 5, y: 5, width: view.frame.size.width - 20, height: 20.0))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .thin)
        
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        
        
        switch section {
        case 0:
            label.text =  "History"
            label.textColor = UIColor(hexString: "#325d79")
            imageV.image = UIImage(named: "ic_history")
            headerView.backgroundColor = UIColor(hexString: "#e84b3a", alpha: 0.2)
        case 1:
            label.text =  "Most searched"
            label.textColor = UIColor(hexString: "#f26627")
            imageV.image = UIImage(named: "ic_trending_up")
            headerView.backgroundColor = UIColor(hexString: "#2980b9", alpha: 0.2)
        default:
            label.text =  "Top Headline"
            label.textColor = UIColor(hexString: "#ee4540")
            imageV.image = UIImage(named: "ic_star")
            headerView.backgroundColor = UIColor(hexString: "#d1404a", alpha: 0.2)
        }
        
        label.font = UIFont.boldSystemFont(ofSize: 12.0)

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

        headerView.layer.cornerRadius = 10.0
        rHeader.addSubview(headerView)
        
        return rHeader
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
