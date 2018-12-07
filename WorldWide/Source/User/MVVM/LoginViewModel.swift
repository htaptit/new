//
//  LoginViewModel.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 12/4/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewModel {
    
    let model : LoginModel = LoginModel()
    let disposebag = DisposeBag()
    
    // Initialise ViewModel's
    let emailIdViewModel = EmailIdViewModel()
    let passwordViewModel = PasswordViewModel()
    
    // Fields that bind to our view's
    let isSuccess : Variable<Bool> = Variable(false)
    let isLoading : Variable<Bool> = Variable(false)
    let errorMsg : Variable<String> = Variable("")
    
    func validateCredentials() -> Bool{
        return emailIdViewModel.validateCredentials() && passwordViewModel.validateCredentials();
    }
    
    func loginUser(){
        
        // Initialise model with filed values
        model.email = emailIdViewModel.data.value
        model.password = passwordViewModel.data.value
        
        self.isLoading.value = true

        WWService.signin(username: model.email, password: model.password)
            .subscribe(onNext: { (user) in
                UserCurrent.saveUser(user)
                
                self.isLoading.value = false
                self.isSuccess.value = true
            }, onError: { (error) in
                debugPrint("##### Error \(error)######")
                self.isLoading.value = false
                self.errorMsg.value = error.localizedDescription
                self.alertErrorMessage()
            }, onCompleted: {
                debugPrint("##### Login completed ######")
            }) {
                debugPrint("##### Login success ######")
            }.disposed(by: disposebag)
    }
    
    func alertValidateMessage() {
        let alertVC = UIAlertController(title: "Notification", message: "Email or Password is incorrect", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertVC.addAction(ok)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    func alertErrorMessage() {
        let alertVC = UIAlertController(title: "Notification", message: self.errorMsg.value, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertVC.addAction(ok)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
}
