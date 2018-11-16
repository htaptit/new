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

class LoginViewController: ASViewController<ASScrollNode> {
    let scrollNode = ASScrollNode()
    
    private let bag = DisposeBag()
    
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
        
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        
        statusBarView.backgroundColor = UIColor(hexString: "#5d5e72")
        
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            let from = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: self.FromArea)
            from.style.layoutPosition.y = UIScreen.main.bounds.height / 4 + 40.0
            
            let logo = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: self.logoArea)
            logo.style.layoutPosition.y = UIScreen.main.bounds.height / 4
            
            let ab = ASAbsoluteLayoutSpec(children: [from, logo])
            
            return ab
        }
        
        scrollNode.backgroundColor = UIColor(hexString: "#5d5e72")
        
        FromArea.signinProtocol = self
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
                UserCurrent.saveUser(user.token, user.time_to_live, user.userId)
            }, onError: { (error) in
                debugPrint("##### Error \(error)######")
            }, onCompleted: {
                debugPrint("##### Login success ######")
            }) {
                debugPrint("##### Login success ######")
        }.disposed(by: bag)
    }
}
