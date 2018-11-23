//
//  FormLoginDisplay.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//
import UIKit
import AsyncDisplayKit

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
        leftIcn.image = UIImage(named: "ic_verified_user")
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
        node.titleNode.calculateSizeThatFits(node.style.preferredSize)
        return node
    }()
    
    private let signup: ASTextNode = {
        let node = ASTextNode()
        
        let title = NSAttributedString(string: "Signup",
                                       attributes: [
                                        NSAttributedStringKey.foregroundColor: UIColor(hexString: "#27ae60"),
                                        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold),
                                        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue])
        node.attributedText = title
        node.maximumNumberOfLines = 1
        
        node.calculateSizeThatFits(CGSize(width: UIScreen.main.bounds.width - 50, height: CGFloat.infinity))
        node.isUserInteractionEnabled = true
        return node
        
    }()
    
    private let forgotPassword: ASTextNode = {
        let node = ASTextNode()
        let title = NSAttributedString(string: "Forgot password ?",
                                       attributes: [
                                        NSAttributedStringKey.foregroundColor: UIColor(hexString: "#27ae60"),
                                        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold),
                                        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue])
        
        node.attributedText = title
        node.maximumNumberOfLines = 1
        
        node.isUserInteractionEnabled = true
        
        return node
        
    }()
    
    private let down: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 50, height: 50)
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        self.backgroundColor = UIColor.white
        
        // target
        login.addTarget(self, action: #selector(signin(_:)), forControlEvents: .touchUpInside)
        forgotPassword.addTarget(self, action: #selector(forgotPassword(_:)), forControlEvents: .touchUpInside)
        signup.addTarget(self, action: #selector(signupAction(_:)), forControlEvents: .touchUpInside)
        down.addTarget(self, action: #selector(resetToLoginForm), forControlEvents: .touchUpInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let areaTextField = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 25.0,
                                              justifyContent: .start,
                                              alignItems: .center,
                                              children: [self.username,
                                                         self.password,
                                                         self.forgotPassword])
        
        let root = ASStackLayoutSpec(direction: .vertical, spacing: 25.0, justifyContent: .start, alignItems: .center, children: [areaTextField, self.login, self.signup])
        
        if self.isForgetPassword {
            areaTextField.children?.removeAll(where: {!$0.isEqual(self.username)})
            root.children?.removeAll(where: {$0.isEqual(self.signup)})
            
            self.login.setTitle("Send", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
            self.down.setImage(UIImage(named: "ic_keyboard_arrow_down"), for: .normal)
            root.children?.append(self.down)
        }
        
        if self.isSignup {
            areaTextField.children?.removeAll(where: {$0.isEqual(self.forgotPassword)})
            root.children?.removeAll(where: {$0.isEqual(self.signup)})
            
            areaTextField.children?.append(self.verifiedPassword)
            
            self.login.setTitle("Signup", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
            self.down.setImage(UIImage(named: "ic_keyboard_arrow_up"), for: .normal)
            root.children?.append(self.down)
        }

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 60, left: 30, bottom: 50, right: 30), child: root)
    }
    
    @objc private func resetToLoginForm() {
        self.isForgetPassword = false
        self.isSignup = false
        self.verifiedPassword.removeFromSupernode()
        self.down.removeFromSupernode()
        
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true) {
            self.login.setTitle("Signin", with: UIFont.systemFont(ofSize: 12.0, weight: .bold), with: UIColor.white, for: .normal)
        }
    }
    
    @objc private func signin(_ sender: ASButtonNode) {
        sender.pulsate()
        self.signinProtocol?.signin(username: self.username.textField.text, password: self.password.textField.text)
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
        
        self.forgotPassword.removeFromSupernode()
        self.signup.removeFromSupernode()
        
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
    }
}

protocol SigninProtocol: class {
    func signin(username: String?, password: String?)
}
