//
//  UnboxDateFormater.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 4/19/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation


class UnboxDateFormater {
    public static func date(format: String = "yyyy-mm-dd'T'H:m:s'Z'") -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
