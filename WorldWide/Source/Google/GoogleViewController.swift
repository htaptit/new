//
//  GoogleViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/15/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import AsyncDisplayKit
import RxSwift

class GoogleViewController: ASViewController<ASTableNode> {
    
    private let refreshControl = UIRefreshControl()
    private var bag = DisposeBag()
    
    var earticles: Articles?
    var isEnd: Bool = false
    
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
        
        self.refreshControl.tintColor = UIColor.red
        self.refreshControl.attributedTitle = NSAttributedString(string: "Fetching New Articles ...")
        self.refreshControl.addTarget(self, action: #selector(self.refreshWeatherData(_:)), for: UIControl.Event.valueChanged)
        node.view.refreshControl = self.refreshControl
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        self.fetchNewBatchWidthContext(nil)
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
    
    func fetchNewBatchWidthContext(_ context: ASBatchContext?) {
        if isEnd {
            context?.completeBatchFetching(true)
            return
        }
        
        WWService.getEArticles(sids: [1,2,3], offset: self.earticles?.articles.count ?? 0)
            .subscribe(onNext: { (tops) in
                if tops.articles.isEmpty {
                    self.isEnd = true
                    return
                }
                if let _ = self.earticles {
                    self.earticles?.append(mappable: tops)
                } else {
                    self.earticles = tops
                }
                
                self.addRowsIntoTableNode(newTopCount: tops.articles.count)
            }, onError: { (error) in
                context?.completeBatchFetching(true)
            }, onCompleted: {
                context?.completeBatchFetching(true)
            }) {
                context?.completeBatchFetching(true)
        }.disposed(by: bag)
    }
    
    func addRowsIntoTableNode(newTopCount newTops: Int) {
        guard let articles = self.earticles?.articles else {  return }
        let indexRange = (articles.count - newTops..<articles.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        self.node.insertRows(at: indexPaths, with: .none)
    }
    
}

extension GoogleViewController: ASTableDataSource, ASTableDelegate {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if let articles = self.earticles?.articles {
            return articles.count
        }
        return 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let article = self.earticles!.articles[indexPath.row]
        let nodeBlock: ASCellNodeBlock = {
            return Google(article: article)
        }

        return nodeBlock
        
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let articles = self.earticles?.articles {
            let vc = WebViewController(url: articles[indexPath.row].url)
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            vc.ww_dissmiss = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.fetchNewBatchWidthContext(context)
    }
}

extension GoogleViewController: HandleDissmiss {
    func didDissmiss() {
        // mark code
    }
}

protocol HandleDissmiss: class {
    func didDissmiss()
}
