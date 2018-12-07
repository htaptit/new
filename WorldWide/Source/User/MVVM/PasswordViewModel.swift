//
//  PasswordViewModel.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 12/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import RxSwift

class PasswordViewModel: ValidationViewModel {
    var errorMessage: String = "Please enter a vaild password"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        guard validateLength(text: data.value, size: (min: 6, max: 15)) else {
            errorValue.value = errorMessage
            return false
        }
        
        errorValue.value = ""
        return true
    }
    
    func validateLength(text: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(text.count)
    }
}


