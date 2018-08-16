//
//  DetailWebViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 5/3/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import AsyncDisplayKit
import WebKit
import Unbox

var myContext = 0

extension DetailWebViewController: WKNavigationDelegate {
    //WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if url.absoluteString.contains("/something") {
                // if url contains something; take user to native view controller

                decisionHandler(.cancel)
            } else if url.absoluteString.contains("done") {
                //in case you want to stop user going back

                decisionHandler(.allow)
            } else if url.absoluteString.contains("AuthError") {
                //in case of erros, show native allerts
            }
            else{
                decisionHandler(.allow)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
}

class DetailWebViewController: ASViewController<ASDisplayNode> {
    var url: String?
    
    var webView: WKWebView!

    var progressView: UIProgressView!
    
    init(url: String?) {
        if let url_str = url {
            self.url = url_str
        }

        super.init(node: ASDisplayNode())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //init
    override func loadView() {
        //add webview
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        //add progresbar to navigation bar
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        progressView.tintColor = UIColor.darkText
        navigationController?.navigationBar.addSubview(progressView)
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        progressView.frame = CGRect(x: 0, y: navigationBarBounds!.size.height - 2, width: navigationBarBounds!.size.width, height: 2)
    }
    
    //deinit
    deinit {
        //remove all observers
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        //remove progress bar from navigation bar
        progressView.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = self.url, let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
        // // add observer for key path
        webView.addObserver(self, forKeyPath: "title", options: .new, context: &myContext)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: &myContext)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let change = change else { return }
        if context != &myContext {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if keyPath == "title" {
            if let title = change[NSKeyValueChangeKey.newKey] as? String {
                self.navigationItem.title = title
            }
            return
        }
        if keyPath == "estimatedProgress" {
            if let progress = (change[NSKeyValueChangeKey.newKey] as AnyObject).floatValue {
                progressView.progress = progress;
            }
            return
        }
    }

}
