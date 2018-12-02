//
//  TextFieldNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/23/18.
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
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

