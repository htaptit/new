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
import Alamofire

class ResponseError {
    static let invaildJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
}
// underlying : code 6

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
                        debugPrint("One: \(error.response)")
                        throw error
                    }
                } catch let error {
                    if let e = error as? MoyaError {
                        debugPrint(e.response?.statusCode)
                    }
 
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
    
    static func send<T: Mappable>(api: WWAPI) -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            let request = WWAPIAdap.shared.request(api, completion: { (result) in
                do {
                    switch result {
                    case .success(let response):
                        let _ = try response.filterSuccessfulStatusCodes()
                        let JsonObject = try response.mapJSON()
                        
                        if let model: T = Mapper<T>().map(JSONObject: JsonObject) {
                            observer.onNext(model)
                            observer.onCompleted()
                        } else {
                            throw ResponseError.invaildJSONFormat
                        }
                        
                    case .failure(let error):
                        throw error
                    }
                } catch let error {
                    if let e = error as? MoyaError {
                        debugPrint(e.response?.statusCode)
                    }
                    
                    observer.onError(error)
                    observer.onCompleted()
                }
            })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
