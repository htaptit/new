//
//  ASTextNode.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/3/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension ASTextNode {
    func setTextToCenter(text: String = "", topPading: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor : UIColor(hexString: "#35a512"),
                                                                            NSAttributedStringKey.paragraphStyle: paragraphStyle,
                                                                            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)])
        self.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - WebConstants.ADDRESSBAR.SPACING_ITEMS * 4 - WebConstants.ADDRESSBAR.SIZE_BUTTONS.width * 4,
                                          height: WebConstants.ADDRESSBAR.HEIGTH)
        self.textContainerInset.top = topPading
    }
}
