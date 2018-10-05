//
//  ArticleExtraction.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 8/9/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import Moya

enum ArticleExtraction {
    case parser(urlStr: String)
}

extension ArticleExtraction: TargetType {
    var baseURL: URL  {
        guard let url = URL(string: "https://mercury.postlight.com") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .parser:
            return "/parser"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .parser :
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        switch self {
        case .parser(let urlStr):
            params["url"] = urlStr
            return params
        }
    }
    
    var parameterEncoding:ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["X-Api-Key" : "tQ0zdAMhOVvgTpjIrTwgFzd3AdvbderHUEg1EhcS"]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .parser:
            if let _ = self.parameters {
                return .requestParameters(parameters: self.parameters!, encoding: parameterEncoding)
            }
            
            return .requestPlain
        }
    }
}

struct ArticleExtractionAdap {
    
    static let provider = MoyaProvider<ArticleExtraction>()
    
    static func request(target: ArticleExtraction, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
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

