//
//  Tops.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class Tops: Mappable {
    var articles: [Article]!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        self.articles <- map["articles"]
    }
}
