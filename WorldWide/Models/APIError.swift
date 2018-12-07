//
//  Error.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 12/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class APIError: Mappable {
    var statusCode: Int?
    var name: String?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statusCode <- map["statusCode"]
        name <- map["name"]
        message <- map["message"]
    }
}
