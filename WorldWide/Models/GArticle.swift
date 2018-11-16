//
//  GArticle.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/9/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import ObjectMapper

class GArticle: Mappable {
    
    var sourceid: String!
    var sourcename: String!
    var author: String?
    var title: String?
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: Date?
    var content: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        sourceid <- map["source.id"]
        sourcename <- map["source.name"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- (map["url"], URLTransform())
        urlToImage <- (map["urlToImage"], URLTransform())
        publishedAt <- (map["publishedAt"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"))
        content <- map["content"]
    }
}
