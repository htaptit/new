//
//  TechLabNetwork.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 4/23/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Moya

enum MyApi {
    case nytimes_crawl(url_string: String)
    case nytimes_article_content(url_string: String)
}

extension MyApi: TargetType {
    
    var baseURL: URL { return URL(string: "http://192.168.0.88:3000")! }
    
    var method: Moya.Method {
        switch self {
        case .nytimes_crawl,
             .nytimes_article_content:
                return .get
        }
    }
    
    var path: String {
        switch self {
        case .nytimes_crawl(let url):
            return "/nytimes_crawl/\(url)"
            
        case .nytimes_article_content(let url):
            return "/nytimes_crawl/article/\(url)"
        }
    }
    
    var parameterEncoding:ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: [String: Any]? {
        var _ = [String: Any]()
        switch self {
        case .nytimes_crawl,
             .nytimes_article_content:
            return nil
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
}

struct MyApiAdap {
    static let provider = MoyaProvider<MyApi>()
    
    static func request(target: MyApi, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    let error = NSError(domain: target.baseURL.absoluteString, code: 0, userInfo: [NSLocalizedDescriptionKey: "### Code : \(response.statusCode), description: \(response.description) ###"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}

