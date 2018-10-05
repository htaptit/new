//
//  GNTopHeadLines.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct Article {
    let sourceid: String
    let sourcename: String
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date?
    let content: String?
}

extension Article: Unboxable {
    init(unboxer: Unboxer) throws {
        self.sourceid = try unboxer.unbox(keyPath: "sid")
        self.sourcename = try unboxer.unbox(keyPath: "sname")
        self.author = try? unboxer.unbox(keyPath: "author")
        self.title = try? unboxer.unbox(keyPath: "title")
        self.description = try? unboxer.unbox(keyPath: "description")
        self.url = try? unboxer.unbox(keyPath: "url")
        self.urlToImage = try? unboxer.unbox(keyPath: "urlToImage")
        self.publishedAt = try? unboxer.unbox(keyPath: "publishedAt", formatter: UnboxDateFormater.date())
        self.content = try? unboxer.unbox(keyPath: "content")
    }
}

