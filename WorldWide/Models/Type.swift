//
//  Type.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class Type: Mappable {
    
    var name: String?
    var image: URL?
    var sources: [Sources]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        image <- (map["image"], URLTransform())
        sources <- map["sources"]
    }
}

