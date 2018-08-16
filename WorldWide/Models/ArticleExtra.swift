//
//  ArticleExtra.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 8/9/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct ArticleExtra {
//    let author: String?
//    let authorUrl: URL?
//    let siteName: String?
//    let title: String?
    let html: String
}

extension ArticleExtra: Unboxable {
    init(unboxer: Unboxer) throws {
//        self.author = try? unboxer.unbox(keyPath: "objects.author")
//        self.authorUrl = try? unboxer.unbox(keyPath: "objects.authorUrl")
//        self.siteName = try? unboxer.unbox(keyPath: "objects.siteName")
//        self.title = try? unboxer.unbox(keyPath: "objects.title")
        self.html = try unboxer.unbox(keyPath: "objects.0.html")
    }
}

// https://www.diffbot.com/testdrive/?api=article&token=e9a7c90b3b0725d396b868cfd1f3151a&url=https%3A%2F%2Fwww.nytimes.com%2F2018%2F08%2F09%2Fopinion%2Fdoes-sacha-baron-cohen-understand-israel.html
