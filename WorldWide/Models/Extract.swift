//
//  Extract.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 9/25/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct Extract {
    let title: String?
    let content: String?
    let date_published: String?
}

extension Extract: Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try? unboxer.unbox(key: "title")
        self.content = try? unboxer.unbox(key: "content")
        self.date_published = try? unboxer.unbox(key: "date_published")
    }
}
