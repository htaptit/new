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
        sourceid <- map["sources.id"]
        sourcename <- map["sources.name"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- (map["publishedAt"], DateTransform())
        content <- map["content"]
    }
}
