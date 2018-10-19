//
//  EnumFavoriteURL.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 8/16/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation

enum NewsSource: String, EnumCollection, CaseCountable {
    static var caseCount: Int = 0
    
    case cnn
    case abc_news
    case the_new_york_times
    case usa_today
    case google_news
    
    
    
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
        case .google_news:
            return "google-news"
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
        case .google_news:
            return "news.google.com"
        }
    }
    
    func fullDomain(source: NewsSource) -> String {
        switch self {
        case .cnn,
             .the_new_york_times,
             .usa_today,
             .google_news:
            return "https://www.\(source.shortDomain)"
        case .abc_news:
            return "http://www.\(source.shortDomain)"
        }
    }
    
    func getFavoriteIconOfDomain() -> String {
        return "https://icon-locator.herokuapp.com/icon?url=\(fullDomain(source: self))&size=70..120..200"
    }
}
