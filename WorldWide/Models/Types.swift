//
//  Types.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class Types: Mappable {
    var types: [Type]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        types <- map["types"]
    }
}
