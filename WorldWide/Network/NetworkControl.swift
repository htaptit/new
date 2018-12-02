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
    case top_headlines(query: String?, sources: [String]?, domains: [String]?, from: String?, to: String?, language: String?, sortBy: String?, pageSize: Int?, page: Int?)
    case gheadline(country: String?, page: Int?)
    
    // mineapi
    case everything(query: String?, sources: [String]?, domains: [String]?, from: String?, to: String?, language: String?, sortBy: String?, pageSize: Int?, page: Int?)
    case get_asources()
    case signin(username: String?, passwd: String?)
    case earticles(sids: [Int], offset: Int)
    case types()
}

extension WWAPI : TargetType {
    var baseURL: URL  {
        switch self {
        case .top_headlines,
             .gheadline:
            guard let url = URL(string: "https://newsapi.org") else {
                fatalError("base url could not be configured.")
            }
            
            return url
        default:
            guard let url = URL(string: "http://localhost:3000/api") else {
                fatalError("base url could not be configured.")
            }
            
            return url
        }
    }
    
    var path: String {
        switch self {
        case .top_headlines,
             .gheadline:
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
        case .types:
            return "/types"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .top_headlines,
             .everything,
             .get_asources,
             .earticles,
             .gheadline,
             .types:
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
            if let _ = sources { params["sources"] = sources!.compactMap( { $0 } ).joined(separator: ",") }
            if let _ = domains { params["domains"] = domains!.compactMap( { $0 } ).joined(separator: ",") }
            if let _ = from { params["from"] = from! }
            if let _ = to { params["to"] = to! }
            if let _ = language { params["language"] = language! }
            if let _ = sortBy { params["sortBy"] = sortBy! }
            if let _ = pageSize { params["pageSize"] = pageSize! }
            if let _ = page { params["page"] = page! }
            return params
            
        case .everything(let query, let sources, let domains, let from, let to, let language, let sortBy, let pageSize, let page):
            if let _ = query { params["q"] = query! }
            if let _ = sources { params["sources"] = sources!.compactMap( { $0 } ).joined(separator: ",") }
            if let _ = domains { params["domains"] = domains!.compactMap( { $0 } ).joined(separator: ",") }
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
            if let _ = username {
                params["username"] = username!
            }
            
            if let _ = passwd {
                params["password"] = passwd!
            }
            
            return params
        case .gheadline(let country, let page):
            if let _ = country {
                params["country"] = country!
            }
            
            if let _ = page {
                params["page"] = page
            }
            
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
                    params["filter"] = ["where": ["sourcesId": sid], "offset": offset]
                }
            }
            
            return params
            
        case .types:
            return params
        }
    }
    
    var parameterEncoding:ParameterEncoding {
        return CompositeEncoding.default
    }
    
    var headers: [String : String]? {
        switch self {
        case .top_headlines,
             .gheadline:
            // key by newsapi.org
            // account: hoang.tronganh@icloud.com
            return ["X-Api-Key" : "2c297d7fb6b940ff9eb0e53651ad8997"]
        default:
            return ["Authorization": UserDefaults().string(forKey: DefaultKeys.WW_SESSION_USER_TOKEN.rawValue) ?? ""]
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
             .earticles,
             .gheadline,
             .types:
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


