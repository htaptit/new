//
//  GArticles.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/9/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct GArticles {
    var articles: [GArticle]
}

extension GArticles: Unboxable {
    init(unboxer: Unboxer) throws {
        self.articles = try unboxer.unbox(key: "articles")
    }
    
    mutating func append(unboxable_objec: Unboxable) {
        if (type(of: unboxable_objec) == GArticles.self) {
            let s = unboxable_objec as! GArticles
            
            self.articles.append(contentsOf: s.articles)
        }
    }
}
