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
        let leftIcn = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        leftIcn.layer.cornerRadius = 10
        leftIcn.contentMode = .scaleAspectFit
        leftIcn.image = UIImage(named: "ic_account_circle")
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 20, height: 20))
        iconContainerView.addSubview(leftIcn)
        node.textField.leftView = iconContainerView
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 30.0)
        return node
    }()
    
    private let password: TextFieldNode = {
        let node = TextFieldNode(isSecret: true)
        node.placeHolder = "Password"
        node.textField.leftViewMode = .always
        let leftIcn = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        leftIcn.layer.cornerRadius = 10
        leftIcn.contentMode = .scaleAspectFit
        leftIcn.image = UIImage(named: "ic_lock_open")
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 20, height: 20))
        iconContainerView.addSubview(leftIcn)
        node.textField.leftView = iconContainerView
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 30.0)
        return node
    }()
    
    private let verifiedPassword: TextFieldNode = {
        let node = TextFieldNode(isSecret: true)
        node.placeHolder = "Verified password"
        node.textField.leftViewMode = .always
        let leftIcn = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        leftIcn.layer.cornerRadius = 10
        leftIcn.contentMode = .scaleAspectFit
        leftIcn.image = UIImage(named: "ic_lock_open")
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 20, height: 20))
        iconContainerView.addSubview(leftIcn)
        node.textField.leftView = iconContainerView
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 30.0)
        return node
    }()
    
    private let login: ASButtonNode = {
        let node = ASButtonNode()
        
        node.setTitle("Signin", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
        node.backgroundColor = UIColor(hexString: "#2a4849")
        node.cornerRadius = 15.0
        node.isUserInteractionEnabled = true
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 30)
        return node
    }()
    
    private let signup: ASTextNode = {
        let node = ASTextNode()
        let title = NSAttributedString(string: "Signup", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#27ae60"), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
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
        automaticallyManagesSubnodes = false
        
        self.addSubnode(username)
        self.addSubnode(password)
        self.addSubnode(forgotPassword)
        self.addSubnode(login)
        self.addSubnode(signup)
        
        self.backgroundColor = .white
        // target
        login.addTarget(self, action: #selector(signin(_:)), forControlEvents: .touchUpInside)
        forgotPassword.addTarget(self, action: #selector(forgotPassword(_:)), forControlEvents: .touchUpInside)
        signup.addTarget(self, action: #selector(signupAction(_:)), forControlEvents: .touchDragInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let areaTextField = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 25.0,
                                              justifyContent: .start,
                                              alignItems: .center,
                                              children: [self.username,
                                                         self.password,
                                                         self.forgotPassword])
        
        if self.isForgetPassword {
            areaTextField.children?.removeLast()
            areaTextField.children?.remove(at: 1)
            
            self.login.setTitle("Send", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
        }
        
        let root = ASStackLayoutSpec(direction: .vertical, spacing: 25.0, justifyContent: .start, alignItems: .center, children: [areaTextField, self.login, self.signup])
        
        if self.isSignup {
            areaTextField.children?.remove(at: 2)
            root.children?.remove(at: 2)
            
            areaTextField.children?.append(self.verifiedPassword)
            
            self.login.setTitle("Signup", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
        }

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 60, left: 30, bottom: 50, right: 30), child: root)
    }
    
    @objc private func signin(_ sender: ASButtonNode) {
        sender.pulsate()
//        self.signinProtocol?.signin(username: self.username.textField.text, password: self.password.textField.text)
    }
    
    @objc private func forgotPassword(_ sender: ASTextNode) {
        self.forgotPassword.removeFromSupernode()
        self.signup.removeFromSupernode()
        self.password.removeFromSupernode()
        
        self.isForgetPassword = true
        self.isSignup = false
        
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
    }
    
    @objc private func signupAction(_ sender: ASTextNode) {
        self.isForgetPassword = false
        self.isSignup = true
        
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
    }
}

protocol SigninProtocol: class {
    func signin(username: String?, password: String?)
}
