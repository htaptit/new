//
//  LoginViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa

class LoginViewController: ASViewController<ASScrollNode> {
    let scrollNode = ASScrollNode()
    
    private let bag = DisposeBag()
    
     private let bag1 = DisposeBag()
    private let logoArea: LogoAreaDisplay = {
        let node = LogoAreaDisplay()
        return node
    }()
    
    private let FromArea: FormLoginDisplay = {
        let node = FormLoginDisplay()
        node.cornerRadius = 5.0
        return node
    }()
    
    init() {
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        
        super.init(node: scrollNode)
        
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            let from = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: self.FromArea)
            from.style.layoutPosition.y = UIScreen.main.bounds.height / 4 + 40.0
            
            let logo = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: self.logoArea)
            logo.style.layoutPosition.y = UIScreen.main.bounds.height / 4
            
            let ab = ASAbsoluteLayoutSpec(children: [from, logo])
            
            return ab
        }
        scrollNode.backgroundColor = UIColor.white
        
        FromArea.signinProtocol = self
        
        UserDefaults.standard.rx
            .observe(String.self, DefaultKeys.WW_SESSION_USER_TOKEN.rawValue)
            .subscribe(onNext: { (value) in
                if let _ = value {
                    UIApplication.shared.keyWindow?.setRootViewController(AppDelegate.shared.rootViewController.switchToHome(), options: UIWindow.TransitionOptions(direction: UIWindow.TransitionOptions.Direction.toBottom, style: UIWindow.TransitionOptions.Curve.linear))
                }
            })
            .disposed(by: bag1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Login"
        self.navigationController?.navigationBar.isTranslucent = false
    }

}

extension LoginViewController: SigninProtocol {
    func signin(username: String?, password: String?) {
        let _ = UserCurrent.clearUserSession()

        guard let name = username, let passw = password else {
            self.view.endEditing(true)
            return
        }

        WWService.signin(username: name, password: passw)
            .subscribe(onNext: { (user) in
                UserCurrent.saveUser(user)
            }, onError: { (error) in
                debugPrint("##### Error \(error)######")
            }, onCompleted: {
                debugPrint("##### Login success ######")
            }) {
                debugPrint("##### Login success ######")
        }.disposed(by: bag)
        
        
        
    }
}
