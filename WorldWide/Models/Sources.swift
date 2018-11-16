//
//  Sources.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/8/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class Sources: Mappable {
    var sid: String?
    var sname: String?
    var home_url: URL?
    var fav_icon_url: URL?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sid <- map["sid"]
        sname <- map["sname"]
        home_url <- (map["home_url"], URLTransform())
        fav_icon_url <- (map["fav_icon_url"], URLTransform())
    }
}
