//
//  User.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/30/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class User: Mappable {
    var token: String!
    var time_to_live: Int!
    var created_at: Date!
    var userId: Int!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        token <- map["id"]
        time_to_live <- map["ttl"]
        userId <- map["userId"]
        created_at <- (map["created"], DateTransform())
    }
}
