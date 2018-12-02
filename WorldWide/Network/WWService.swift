//
//  DefaultService.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/1/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import RxSwift

class WWService: BaseService {
    static func _getEArticles(sids: [Int], offset: Int) -> Observable<Articles> {
        return requestJSONRx(api: .earticles(sids: sids, offset: offset)).map { (json) in
            if let earticles = Articles(JSON: json) {
                return earticles
            } else {
                throw ResponseError.invaildJSONFormat
            }
            }.distinctUntilChanged({ (hls, rls) -> Bool in
                return hls.articles.first === rls.articles.first
            }).throttle(1.0, scheduler: MainScheduler.instance)
    }
    
    
    static func getEArticles(sids: [Int], offset: Int) -> Observable<Articles> {
        return requestJSONRx(api: .earticles(sids: sids, offset: offset)).map { (json) in
            if let earticles = Articles(JSON: json) {
                return earticles
            } else {
                throw ResponseError.invaildJSONFormat
            }
            }.distinctUntilChanged({ (hls, rls) -> Bool in
                return hls.articles.first === rls.articles.first
            }).throttle(1.0, scheduler: MainScheduler.instance)
    }
    
    static func getHeadLinesByCountry(country: String?, page: Int?) -> Observable<GArticles> {
        return requestJSONRx(api: .gheadline(country: country, page: page)).map({ (json) in
            if let headlines = GArticles(JSON: json) {
                return headlines
            } else {
                throw ResponseError.invaildJSONFormat
            }
        }).throttle(1.0, scheduler: MainScheduler.instance)
    }
    
    static func getSourceRelationType() -> Observable<Types> {
        return requestJSONRx(api: .types()).map({ (json) in
            if let sources = Types(JSON: json) {
                return sources
            } else {
                throw ResponseError.invaildJSONFormat
            }
        }).throttle(1.0, scheduler: MainScheduler.instance)
    }
    
    static func signin(username: String?, password: String?) -> Observable<User> {
        return requestJSONRx(api: .signin(username: username, passwd: password)).map({ (json) in
            if let user = User(JSON: json) {
                return user
            } else {
                throw ResponseError.invaildJSONFormat
            }
        })
    }
}
