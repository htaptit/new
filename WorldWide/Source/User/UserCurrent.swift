//
//  UserCurrent.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/30/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation

struct UserCurrent {
    static let (access_token, ttl, uid) = ("token", "timeToLive", "uid")
    static let sessionKey = "ww.usersession"
    
    struct Model {
        var token: String?
        var timeToLive: Int?
        var uid: Int?
        
        init(_ json: [String: Any]) {
            if let _token = json["token"] as? String {
                self.token = _token
            }
            
            if let _ttl = json["timeToLive"] as? Int {
                self.timeToLive = _ttl
            }
            
            if let _userId = json["uid"] as? Int {
                self.uid = _userId
            }
        }
    }
    
    static var saveUser = { (token: String, timeToLive: Int, userId: Int) in
        UserDefaults.standard.set([access_token: token, ttl: timeToLive, uid: userId], forKey: sessionKey)
    }
    
    static var getToken = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: sessionKey) as? [String: Any]) ?? [:])
    }(())
    
    static func clearUserSession() {
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
    
}
