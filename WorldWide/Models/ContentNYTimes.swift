//
//  ContentNYTimes.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 4/23/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Unbox

struct ContentNYTimes {
    var items: [ItemsNYTimes]
}

extension ContentNYTimes: Unboxable {
    init(unboxer: Unboxer) throws {
        self.items = try unboxer.unbox(key: "items")
    }
    
    mutating func append(unboxable_objec: Unboxable) {
        if (type(of: unboxable_objec) == ContentNYTimes.self) {
            let s = unboxable_objec as! ContentNYTimes
            self.items.append(contentsOf: s.items)
        }
    }
}
