//
//  LoginViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 10/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class LoginViewController: ASViewController<ASScrollNode> {
    let scrollNode = ASScrollNode()
    
    private let logoArea: LogoAreaDisplay = {
        let node = LogoAreaDisplay()
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        return node
    }()
    
    private let FromArea: FormLoginDisplay = {
        let node = FormLoginDisplay()
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        return node
    }()
    
    init() {
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        
        super.init(node: scrollNode)
        
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            let scrollStack = ASStackLayoutSpec.vertical()
            scrollStack.spacing = 15.0
            scrollStack.justifyContent = .start
            scrollStack.alignItems = .notSet
            scrollStack.children = [self.logoArea, self.FromArea]
            
            return scrollStack
        }
        
        scrollNode.backgroundColor = .white
        
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
        guard let name = username, let passw = password else {
            self.view.endEditing(true)
            return
        }
        
        let target = WWAPI.signin(username: name, passwd: passw)
//        GoogleApiAdap.request(target: target, success: { (success) in
////            do {
////                let user: User = try unbox(data: success.data)
////                
////                UserCurrent.saveUser(user.token, user.time_to_live, user.userId)
////                
////                debugPrint("##### Login success ######")
////            } catch {
////                debugPrint("Error parse data !")
////            }
//        }, error: { (error) in
//            debugPrint(error)
//        }) { (fail) in
//            debugPrint(fail)
//        }
    }
}
