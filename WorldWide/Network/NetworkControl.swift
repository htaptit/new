//
//  NetworkControl.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//
import Foundation
import Moya
//import Alamofire

enum WWAPI {
    // newsapi
    case top_headlines(query: String?, sources: [NewsSource]?, domains: [NewsSource]?, from: String?, to: String?, language: String?, sortBy: String?, pageSize: Int?, page: Int?)
    
    // mineapi
    case everything(query: String?, sources: [NewsSource]?, domains: [NewsSource]?, from: String?, to: String?, language: String?, sortBy: String?, pageSize: Int?, page: Int?)
    case get_asources()
    case signin(username: String, passwd: String)
    case earticles(sids: [Int], offset: Int)
}

extension WWAPI : TargetType {
    var baseURL: URL  {
        switch self {
        case .top_headlines:
            guard let url = URL(string: "https://newsapi.org") else {
                fatalError("base url could not be configured.")
            }
            
            return url
        default:
            guard let url = URL(string: "http://192.168.0.252:3000/api") else {
                fatalError("base url could not be configured.")
            }
            
            return url
        }
    }
    
    var path: String {
        switch self {
        case .top_headlines:
            return "/v2/top-headlines"
        case .everything:
            return "/ggarticles/v1/everything"
        case .get_asources:
            return "/asources"
            
        // 30/10/2018
        case .signin:
            return "/accounts/login"
        case .earticles:
            return "/earticles"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .top_headlines,
             .everything,
             .get_asources,
             .earticles:
            return .get
            
        case .signin:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        switch self {
        case .top_headlines(let query, let sources, let domains, let from, let to, let language, let sortBy, let pageSize, let page):
            if let _ = query { params["q"] = query! }
            if let _ = sources { params["sources"] = sources!.compactMap( { $0.string } ).joined(separator: ",") }
            if let _ = domains { params["domains"] = domains!.compactMap( { $0.shortDomain } ).joined(separator: ",") }
            if let _ = from { params["from"] = from! }
            if let _ = to { params["to"] = to! }
            if let _ = language { params["language"] = language! }
            if let _ = sortBy { params["sortBy"] = sortBy! }
            if let _ = pageSize { params["pageSize"] = pageSize! }
            if let _ = page { params["page"] = page! }
            return params
            
        case .everything(let query, let sources, let domains, let from, let to, let language, let sortBy, let pageSize, let page):
            if let _ = query { params["q"] = query! }
            if let _ = sources { params["sources"] = sources!.compactMap( { $0.string } ).joined(separator: ",") }
            if let _ = domains { params["domains"] = domains!.compactMap( { $0.shortDomain } ).joined(separator: ",") }
            if let _ = from { params["from"] = from! }
            if let _ = to { params["to"] = to! }
            if let _ = language { params["language"] = language! }
            if let _ = sortBy { params["sortBy"] = sortBy! }
            if let _ = pageSize { params["pageSize"] = pageSize! }
            if let _ = page { params["page"] = page! }
            return params
        case .get_asources:
            return nil
            
            
        case .signin(let username, let passwd):
            params["username"] = username
            params["password"] = passwd
            return params
        case .earticles(let sids, let offset):
            if sids.count > 1 {
                var ors: [[String: Int]] = Array(repeating: [:], count: sids.count)
                
                for (key, sid) in sids.enumerated() {
                    ors[key] = ["sourcesId" : sid]
                }
                params["filter"] = ["where": ["or": ors], "offset": offset]
            } else {
                if let sid = sids.first {
                    params["filter"] = ["where": ["sourcesId": sid]]
                }
            }
            
            return params
        }
    }
    
    var parameterEncoding:ParameterEncoding {
        return CompositeEncoding.default
    }
    
    var headers: [String : String]? {
        switch self {
        case .top_headlines:
            // key by newsapi.org
            // account: hoang.tronganh@icloud.com
            return ["X-Api-Key" : "2c297d7fb6b940ff9eb0e53651ad8997"]
        default:
            return ["Authorization": UserCurrent.getToken.token ?? ""]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .top_headlines,
             .everything,
             .get_asources,
             .signin,
             .earticles:
            if let _ = self.parameters {
                return .requestParameters(parameters: self.parameters!, encoding: parameterEncoding)
            }
            
            return .requestPlain
        }
    }
}

struct WWAPIAdap {
    static let shared = MoyaProvider<WWAPI>()
}


