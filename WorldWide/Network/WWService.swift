//
//  DefaultService.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 11/1/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import RxSwift

class WWService: BaseService {
    static func getEArticles(sids: [Int], offset: Int) -> Observable<Tops> {
        return requestJSONRx(api: .earticles(sids: sids, offset: offset)).map { (json) in
            if let earticles = Tops(JSON: json) {
                return earticles
            } else {
                throw ResponseError.invaildJSONFormat
            }
        }
    }
}
