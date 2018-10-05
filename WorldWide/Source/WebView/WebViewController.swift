//
//  WebViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/2/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class WebViewController: ASViewController<ASDisplayNode> {
    
    var ww_dissmiss: HandleDissmiss?
    
    init(url: URL?) {
        let webView = WebView()
        webView.url = url
        
        super.init(node: webView)
        
        webView.w_delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: ASDisplayNode.init())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.isOpaque = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WebViewController: WebViewProtocol {
    func handleClose() {
        self.ww_dissmiss?.didDissmiss()
        self.dismiss(animated: true, completion: nil)
    }
}
