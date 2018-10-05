//
//  WebView.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/3/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//
import UIKit
import AsyncDisplayKit
import WebKit

class WebView: ASDisplayNode {
    var url: URL? {
        didSet {
            if let url = self.url, let host = url.host {
                self.urlASLabel.setTextToCenter(text: host, topPading: 7.0)
            }
        }
    }
    
    var web: WKWebView = WKWebView()
    
    var w_delegate: WebViewProtocol?
    
    private let topImage: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(color: UIColor(hexString: "#dcdcdc"), size: CGSize(width: UIScreen.main.bounds.width / 3, height: WebConstants.ADDRESSBAR.HEIGTH_TOPIMAGE))
        node.contentMode = .scaleAspectFit
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 5, height: WebConstants.ADDRESSBAR.HEIGTH_TOPIMAGE)
        node.cornerRadius = 1.5
        
        return node
    }()
    
    private let closeASButton: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(#imageLiteral(resourceName: "icn_close"), for: .normal)
        node.backgroundColor = .white
        node.style.preferredSize = WebConstants.ADDRESSBAR.SIZE_BUTTONS
        return node
    }()
    
    private let prevASButton: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(#imageLiteral(resourceName: "icn_prev"), for: .normal)
        node.backgroundColor = .white
        node.style.preferredSize = WebConstants.ADDRESSBAR.SIZE_BUTTONS
        return node
    }()
    
    private let urlASLabel: ASTextNode = {
        let node = ASTextNode()
        node.setTextToCenter(topPading: WebConstants.ADDRESSBAR.HEIGTH / 2)
        node.backgroundColor = .white
        return node
    }()
    
    private let nextASButton: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(#imageLiteral(resourceName: "icn_next"), for: .normal)
        node.style.preferredSize = WebConstants.ADDRESSBAR.SIZE_BUTTONS
        node.backgroundColor = .white
        return node
    }()
    
    private let moreASButton: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(#imageLiteral(resourceName: "icn_more"), for: .normal)
        node.backgroundColor = .white
        node.style.preferredSize = WebConstants.ADDRESSBAR.SIZE_BUTTONS
        return node
    }()
    
    private var webASDisplay: ASDisplayNode = ASDisplayNode()
    
    private var tmpWebView: WKWebView?
    
    override init() {
        super.init()
        
        let web = ASDisplayNode.init(viewBlock: { () -> UIView in
            let node = WKWebView()
            node.load(URLRequest(url: self.url!))
            self.tmpWebView = node
            return node
        })
        
        self.webASDisplay = web
        
        automaticallyManagesSubnodes = true
        
        setupTargetForAddressButtons()
    }
    
    private func setupTargetForAddressButtons() {
        self.closeASButton.isUserInteractionEnabled = true
        self.closeASButton.addTarget(self, action: #selector(self.close), forControlEvents: .touchUpInside)
        
        self.prevASButton.isUserInteractionEnabled = true
        self.prevASButton.addTarget(self, action: #selector(self.handleWKPrev), forControlEvents: .touchUpInside)
        
        self.nextASButton.isUserInteractionEnabled = true
        self.nextASButton.addTarget(self, action: #selector(self.handleWKNext), forControlEvents: .touchUpInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topImageVertical = ASStackLayoutSpec(direction: .vertical, spacing: 2.0, justifyContent: .start, alignItems: .center, children: [topImage])
        
        self.webASDisplay.style.preferredSize = CGSize(width: UIScreen.main.bounds.width,
                                                       height: UIScreen.main.bounds.height - WebConstants.ADDRESSBAR.HEIGTH - WebConstants.ADDRESSBAR.HEIGTH_TOPIMAGE - WebConstants.ADDRESSBAR.INSET_TOPIMAGE.top - WebConstants.ADDRESSBAR.INSET.top)
        
        let addressBarHorizontal = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: WebConstants.ADDRESSBAR.SPACING_ITEMS,
                                                     justifyContent: .spaceBetween,
                                                     alignItems: .center,
                                                     children: [closeASButton, prevASButton, urlASLabel, nextASButton, moreASButton])
        
        
        let areaParent = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0.0,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [ASInsetLayoutSpec(insets: WebConstants.ADDRESSBAR.INSET_TOPIMAGE, child: topImageVertical),
                                                      ASInsetLayoutSpec(insets: WebConstants.ADDRESSBAR.INSET, child: addressBarHorizontal),
                                                      ASInsetLayoutSpec(insets: WebConstants.ADDRESSBAR.INSET, child: webASDisplay)])
        
        return areaParent
    }
    
    @objc func close() {
        w_delegate?.handleClose()
    }
    
    @objc func handleWKPrev() {
        guard let __webView = self.tmpWebView else {
            return
        }
        
        if __webView.canGoBack {
            self.tmpWebView?.goBack()
        }
    }
    
    @objc func handleWKNext() {
        guard let __webView = self.tmpWebView else {
            return
        }
        
        if __webView.canGoForward {
            self.tmpWebView?.goForward()
        }
    }
}

protocol WebViewProtocol {
    func handleClose()
}
