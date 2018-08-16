//
//  ArticleContentHtml.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 5/3/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct ArticleContentHtml {
    var content: String
}

extension ArticleContentHtml: Unboxable {
    init(unboxer: Unboxer) throws {
        self.content = try unboxer.unbox(keyPath: "content")
    }
}
