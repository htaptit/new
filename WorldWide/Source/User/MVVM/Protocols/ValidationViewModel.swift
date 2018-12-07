//
//  ValidationViewModel.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 12/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation
import RxSwift

protocol ValidationViewModel {
    var errorMessage: String { get }
    
    // Observables
    var data: Variable<String> { get set }
    var errorValue: Variable<String?> { get }
    
    // Validation
    func validateCredentials() -> Bool
}
