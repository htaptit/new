//
//  UserCurrent.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/30/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import RxSwift

struct UserCurrent {
    static var saveUser = { (user: User) in
        UserDefaults.standard.set(user.token, forKey: DefaultKeys.WW_SESSION_USER_TOKEN.rawValue)
        UserDefaults.standard.set(user.time_to_live, forKey: DefaultKeys.WW_SESSION_USER_TTL.rawValue)
        UserDefaults.standard.set(user.userId, forKey: DefaultKeys.WW_SESSION_USER_UID.rawValue)
    }
    
    static func clearUserSession() {
        UserDefaults.standard.removeObject(forKey: DefaultKeys.WW_SESSION_USER_TOKEN.rawValue)
        UserDefaults.standard.removeObject(forKey: DefaultKeys.WW_SESSION_USER_TTL.rawValue)
        UserDefaults.standard.removeObject(forKey: DefaultKeys.WW_SESSION_USER_UID.rawValue)
    }
    
}
