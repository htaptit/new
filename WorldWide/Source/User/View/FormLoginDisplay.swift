//
//  FormLoginDisplay.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//
import UIKit
import AsyncDisplayKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class TextFieldNode: ASDisplayNode {
    var placeHolder: String?
    
    var textField: UITextField = {
        return UITextField()
    }()
    
    private var textFieldNode: ASDisplayNode!
    
    init(isSecret: Bool = false) {
        super.init()
        
        self.textFieldNode = ASDisplayNode(viewBlock: { () -> UIView in
            self.textField.layer.cornerRadius = 5.0
            self.textField.isSecureTextEntry = isSecret
            self.textField.placeholder = self.placeHolder
            self.textField.borderStyle = UITextBorderStyle.none
            self.textField.setBottomBorder()
            return self.textField
        })
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: self.textFieldNode)
    }
}

class FormLoginDisplay: ASDisplayNode {
    var signinProtocol: SigninProtocol?
    
    private let username: TextFieldNode = {
        let node = TextFieldNode()
        node.placeHolder = "Username"
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 30.0, height: 30.0)
        return node
    }()
    
    private let password: TextFieldNode = {
        let node = TextFieldNode(isSecret: true)
        node.placeHolder = "Password"
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 30.0, height: 30.0)
        return node
    }()
    
    private let login: ASButtonNode = {
        let node = ASButtonNode()
        
        node.setTitle("Signin", with: nil, with: .white, for: .normal)
        node.backgroundColor = UIColor(hexString: "#2a4849")
        node.cornerRadius = 5.0
        node.isUserInteractionEnabled = true
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 35.0)
        return node
    }()
    
    private let signup: ASTextNode = {
        let node = ASTextNode()
        let title = NSAttributedString(string: "You can sign up for an account here", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#27ae60"), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        node.attributedText = title
        node.maximumNumberOfLines = 1
        
        node.calculateSizeThatFits(CGSize(width: UIScreen.main.bounds.width - 50, height: CGFloat.infinity))
        node.isUserInteractionEnabled = true
        return node
        
    }()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        login.addTarget(self, action: #selector(signin), forControlEvents: .touchUpInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let areaTextField = ASStackLayoutSpec(direction: .vertical, spacing: 25.0, justifyContent: .start, alignItems: .center, children: [self.username, self.password, self.login, ASInsetLayoutSpec(insets: UIEdgeInsets(top: 50.0, left: 25.0, bottom: 25.0, right: 25.0), child: self.signup)])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 35.0, left: 25.0, bottom: CGFloat.infinity, right: 25.0), child: areaTextField)
    }
    
    @objc private func signin() {
        self.signinProtocol?.signin(username: self.username.textField.text, password: self.password.textField.text)
    }
}

protocol SigninProtocol: class {
    func signin(username: String?, password: String?)
}
