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
    
    var textField: TextField = {
        return TextField()
    }()
    
    private var textFieldNode: ASDisplayNode!
    
    init(isSecret: Bool = false) {
        super.init()
        self.textFieldNode = ASDisplayNode(viewBlock: { () -> UIView in
            self.textField.isSecureTextEntry = isSecret
            self.textField.placeholder = self.placeHolder
            
            self.textField.font = UIFont.systemFont(ofSize: 12.0)
            self.textField.layer.cornerRadius = 15
            self.textField.layer.borderWidth = 0.1
            self.textField.layer.borderColor = UIColor.gray.cgColor
            
            return self.textField
        })
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: self.textFieldNode)
    }
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

class FormLoginDisplay: ASDisplayNode {
    var isForgetPassword: Bool = false
    
    var isSignup: Bool = false
    
    var signinProtocol: SigninProtocol?

    private let username: TextFieldNode = {
        let node = TextFieldNode()
        node.placeHolder = "Username"
        node.textField.leftViewMode = .always
        let leftIcn = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        leftIcn.image = #imageLiteral(resourceName: "icn_add")
        node.textField.leftView = leftIcn
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 30.0)
        return node
    }()
    
    private let password: TextFieldNode = {
        let node = TextFieldNode(isSecret: true)
        node.placeHolder = "Password"
        node.textField.leftViewMode = .always
        let leftIcn = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        leftIcn.image = #imageLiteral(resourceName: "icn_add")
        node.textField.leftView = leftIcn
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 30.0)
        return node
    }()
    
    private let login: ASButtonNode = {
        let node = ASButtonNode()
        
        node.setTitle("Signin", with: nil, with: .white, for: .normal)
        node.backgroundColor = UIColor(hexString: "#2a4849")
        node.cornerRadius = 15.0
        node.isUserInteractionEnabled = true
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 35.0)
        return node
    }()
    
    private let signup: ASTextNode = {
        let node = ASTextNode()
        let title = NSAttributedString(string: "Sign up", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#27ae60"), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        node.attributedText = title
        node.maximumNumberOfLines = 1
        
        node.calculateSizeThatFits(CGSize(width: UIScreen.main.bounds.width - 50, height: CGFloat.infinity))
        node.isUserInteractionEnabled = true
        return node
        
    }()
    
    private let forgotPassword: ASTextNode = {
        let node = ASTextNode()
        let title = NSAttributedString(string: "Forgot password ?", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#27ae60"), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)])
        
        node.attributedText = title
        node.maximumNumberOfLines = 1
        
        node.isUserInteractionEnabled = true
        return node
        
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.backgroundColor = .white
        // target
        login.addTarget(self, action: #selector(signin), forControlEvents: .touchUpInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let areaTextField = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 25.0,
                                              justifyContent: .start,
                                              alignItems: .center,
                                              children: [self.username,
                                                         self.password])
        if self.isForgetPassword {
            areaTextField.children?.append(self.forgotPassword)
        }
        let root = ASStackLayoutSpec(direction: .vertical, spacing: 25.0, justifyContent: .start, alignItems: .center, children: [areaTextField, self.login])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 60, left: 30, bottom: 50, right: 30), child: root)
    }
    
    @objc private func signin() {
        self.isForgetPassword = true
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
//        self.signinProtocol?.signin(username: self.username.textField.text, password: self.password.textField.text)
    }
}

protocol SigninProtocol: class {
    func signin(username: String?, password: String?)
}
