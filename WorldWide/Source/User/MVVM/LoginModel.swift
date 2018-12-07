//
//  LoginModel.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 12/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation

class LoginModel {
    var email: String = ""
    var password: String = ""
    
    convenience init(email: String, password: String) {
        self.init()
        
        self.email = email
        self.password = password
    }
}
