//
//  EnumFavoriteURL.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 8/16/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation

enum NewsSource: String {
    case cnn
    case abc_news
    case the_new_york_times
    case usa_today
    
    var string: String {
        switch self {
        case .cnn:
            return "cnn"
        case .abc_news:
            return "abc-news"
        case .the_new_york_times:
            return "the-new-york-times"
        case .usa_today:
            return "usa-today"
        }
    }
    
    var shortDomain: String {
        switch self {
        case .cnn:
            return "cnn.com"
        case .abc_news:
            return "abcnews.go.com"
        case .the_new_york_times:
            return "nytimes.com"
        case .usa_today:
            return "usatoday.com"
        }
    }
    
    func fullDomain(source: NewsSource) -> String {
        switch self {
        case .cnn,
             .the_new_york_times,
             .usa_today:
            return "https://www.\(source.shortDomain)"
        case .abc_news:
            return "http://www.\(source.shortDomain)"
        }
    }
    
    func getFavoriteIconOfDomain(source: NewsSource) -> String {
        return "https://icon-locator.herokuapp.com/icon?url=\(fullDomain(source: source))&size=70..120..200"
    }
}
