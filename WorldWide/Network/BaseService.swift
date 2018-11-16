//
//  BaseService.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/1/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import RxSwift
import UIKit
import Moya
import ObjectMapper

class ResponseError {
    static let invaildJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
}

class BaseService {
    
    static func requestJSONRx(api: WWAPI) -> Observable<[String: Any]> {
        return Observable.create({ (observer) -> Disposable in
            let request = WWAPIAdap.shared.request(api, completion: { (result) in
                do {
                    switch result {
                    case .success(let response):
                        let _ = try response.filterSuccessfulStatusCodes()
                        
                        let JSON = try response.mapJSON()
                        
                        if let JSONDict = JSON as? [String: Any] {
                            observer.onNext(JSONDict)
                            observer.onCompleted()
                        } else {
                            throw ResponseError.invaildJSONFormat
                        }
                    case .failure(let error):
                        throw error
                    }
                } catch let error {
                    observer.onError(error)
                    observer.onCompleted()
                }
            })
            
            return Disposables.create {
                request.cancel()
            }
        })
        .debounce(0.1, scheduler: MainScheduler.instance) // Delay truoc khi goi api
    }
}
