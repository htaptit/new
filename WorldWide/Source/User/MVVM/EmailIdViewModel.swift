//
//  LoginViewModel.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 12/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import RxSwift

class EmailIdViewModel : ValidationViewModel {
    
    var errorMessage: String = "Please enter a valid Email"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        
        guard validatePattern(text: data.value) else {
            errorValue.value = errorMessage
            return false
        }
        
        errorValue.value = ""
        return true
    }
    
    func validatePattern(text : String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}
