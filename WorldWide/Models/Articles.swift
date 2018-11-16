//
//  Tops.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class Articles: Mappable {
    var articles: [Article]!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        self.articles <- map["articles"]
    }
    
    func append(mappable: Mappable) {
        if (type(of: mappable) == Articles.self) {
            let s = mappable as! Articles
            
            self.articles.append(contentsOf: s.articles)
        }
    }
}
