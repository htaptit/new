//
//  Tops.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct Tops {
    var articles: [Article]
}

extension Tops: Unboxable {
    init(unboxer: Unboxer) throws {
        self.articles = try unboxer.unbox(key: "articles")
    }
    
    mutating func append(unboxable_objec: Unboxable) {
        if (type(of: unboxable_objec) == Tops.self) {
            let s = unboxable_objec as! Tops
            
            self.articles.append(contentsOf: s.articles)
        }
    }
}
