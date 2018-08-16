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
//            webView.load(URLRequest(url: url))
            webView.loadHTMLString("\"<div><p>Choice and innovation sound nice, but they also echo what happened after the 1954 Brown v. Board of Education Supreme Court decision, when entire white communities in the South closed down schools to avoid the dread integration.</p><p>This kind of racial avoidance has become normal, embedded in the public school experience. It seems particularly so in Los Angeles, a suburb-driven city designed for geographical separation. What looks like segregation to the rest of the world is, to many white residents, entirely neutral — simply another choice.</p><p>Perhaps it should come as no surprise that in 2010, <a href=\"https://www.civilrightsproject.ucla.edu/research/k-12-education/integration-and-diversity/choice-without-equity-2009-report/frankenberg-choices-without-equity-2010.pdf\">researchers at the Civil Rights Project at U.C.L.A.</a> found, in a study of 40 states and several dozen municipalities, that black students in charters are much more likely than their counterparts in traditional public schools to be educated in an intensely segregated setting. The report says that while charters had more potential to integrate because they are not bound by school district lines, “charter schools make up a separate, segregated sector of our already deeply stratified public school system.”</p><p>In a 2017 analysis, data journalists at <a href=\"https://www.apnews.com/e9c25534dfd44851a5e56bd57454b4f5\">The Associated Press</a> found that charter schools were significantly overrepresented among the country’s most racially isolated schools. In other words, black and brown students have more or less resegregated within charters, the very institutions that promised to equalize education.</p><p>This has not stemmed the popular appeal of charters. School board races in California that were once sleepy are now face-offs between well-funded charter advocates and less well-funded teachers’ unions. Progressive politicians are expected to support charters, and they do. Gov. Jerry Brown, who opened a couple of charters during his stint as mayor of Oakland, vetoed legislation two years ago that would have made charter schools more accountable. Antonio Villaraigosa built a reputation as a community organizer who supported unions, but as mayor of Los Angeles, he started a charter-like endeavor called Partnership for Los Angeles Schools.</p><p>This year, charter advocates got their pick for school superintendent, Austin Beutner. And billionaires like Eli Broad have made charters a primary cause: In 2015, an initiative backed in part by Mr. Broad’s foundation outlined a $490 million plan to place half of the students in the Los Angeles district into charters by 2023.</p></div>\"", baseURL: nil)
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
