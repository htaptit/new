//
//  UnboxDateFormater.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 4/19/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation


class UnboxDateFormater {
    public static func date(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ") -> DateFormatter {
        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }
}
