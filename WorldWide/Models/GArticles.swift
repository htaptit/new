//
//  GArticles.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/9/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import ObjectMapper

class GArticles: Mappable {
    var articles: [GArticle]!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        articles <- map["articles"]
    }
    
    func append(mappable: Mappable) {
        if (type(of: mappable) == GArticles.self) {
            let s = mappable as! GArticles
            
            self.articles.append(contentsOf: s.articles)
        }
    }
}
