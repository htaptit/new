//
//  GNTopHeadLines.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class Article: Mappable {
    var sourceid: String!
    var sourcename: String!
    var author: String?
    var title: String?
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var fav_icon_url: URL?
    var publishedAt: Date?
    var content: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        sourceid <- map["sources.sid"]
        sourcename <- map["sources.sname"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- (map["url"], URLTransform())
        urlToImage <- (map["urlToImage"], URLTransform())
        fav_icon_url <- (map["sources.fav_icon_url"], URLTransform())
        publishedAt <- (map["publishedAt"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"))
        content <- map["content"]
    }
}

