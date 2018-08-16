//
//  ItemsNyTimes.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 4/23/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct ItemsNYTimes {
    let text: String
    let imageURLString: String
}

extension ItemsNYTimes: Unboxable {
    init(unboxer: Unboxer) throws {
        self.text = try unboxer.unbox(key: "content")
        self.imageURLString = try unboxer.unbox(key: "image")
    }
}
