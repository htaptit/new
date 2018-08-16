//
//  GoogleViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/15/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ViewAnimator
import AsyncDisplayKit
import Unbox

class GoogleViewController: ASViewController<ASTableNode> {
    
    private let refreshControl = UIRefreshControl()
    
    var topHeadLines: Tops?
    var page: Int = 1
    
    init() {
        super.init(node: ASTableNode())
        self.navigationItem.title = "Google"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.dataSource = self
        node.delegate = self
        node.leadingScreensForBatching = 2.5
        node.view.separatorStyle = .none
        node.view.tableFooterView = nil
        node.view.tableHeaderView = nil
  
        self.refreshControl.tintColor = UIColor.red
        self.refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Articles ...")
        self.refreshControl.addTarget(self, action: #selector(self.refreshWeatherData(_:)), for: UIControlEvents.valueChanged)
        node.view.refreshControl = self.refreshControl
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        self.page = 1
        self.fetchNewBatchWidthContext(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.isToolbarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchNewBatchWidthContext(_ context: ASBatchContext?) {
        GoogleApiAdap.request(target: .everything(query: nil,
                                                  sources: nil,
                                                  domains: "cnn.com, usatoday.com, nytimes.com",
                                                  from: nil, to: nil,
                                                  language: "en", sortBy: nil,
                                                  pageSize: 100,
                                                  page: self.page), success: { (res) in
                                                    DispatchQueue.main.async {
                                                        do {
                                                            let top: Tops = try unbox(data: res.data)
                                                            
                                                            if context == nil && self.refreshControl.isRefreshing {
                                                                self.topHeadLines = nil
                                                                self.node.reloadData()
                                                            }
                                                            
                                                            if let _ = self.topHeadLines {
                                                                self.topHeadLines!.append(unboxable_objec: top)
                                                            } else {
                                                                
                                                                self.topHeadLines = top
                                                                self.refreshControl.endRefreshing()
                                                            }
                                                            self.addRowsIntoTableNode(newTopCount:  top.articles.count)
                                                        } catch {
                                                            debugPrint("parse json error ! ")
                                                        }
                                                    }
                                                    self.page += 1
                                                    context?.completeBatchFetching(true)
                                                    
        }, error: { (error) in
            debugPrint(error.localizedDescription)
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            if let _ = context { context!.completeBatchFetching(true) }
        }) { (moya) in
            debugPrint(moya)
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            if let _ = context { context!.completeBatchFetching(true) }
        }
    }
    
    func addRowsIntoTableNode(newTopCount newTops: Int) {
        guard let articles = self.topHeadLines?.articles else {  return }
        let indexRange = (articles.count - newTops..<articles.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        self.node.insertRows(at: indexPaths, with: .none)
    }
    
}

extension GoogleViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if let articles = self.topHeadLines?.articles {
            return articles.count
        }
        return 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let article = self.topHeadLines!.articles[indexPath.row]
        let nodeBlock: ASCellNodeBlock = {
            return Google(article: article)
        }
        
        return nodeBlock
        
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let articles = self.topHeadLines?.articles {
            let vc = DetailWebViewController(url: articles[indexPath.row].url?.absoluteString)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.fetchNewBatchWidthContext(context)
    }
    
    
}
