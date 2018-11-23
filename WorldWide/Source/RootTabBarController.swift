//
//  TabBarController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class RootTabBarController: ASViewController<ASDisplayNode> {

    private lazy var googleTab: ASNavigationController = {
        let tab = ASNavigationController(rootViewController: GoogleViewController())
        tab.tabBarItem.title = nil
        tab.tabBarItem.image = #imageLiteral(resourceName: "icn_tabbar_news")
        tab.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return tab
    }()
    
    private lazy var newTab: ASNavigationController = {
        let tab = ASNavigationController(rootViewController: SearchViewController())
        tab.tabBarItem.title = nil
        tab.tabBarItem.image = #imageLiteral(resourceName: "icn_tabbar_sources")
        tab.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return tab
    }()
    
    private lazy var sourceTab: ASNavigationController = {
        let tab = ASNavigationController(rootViewController: SourcesViewController())
        tab.tabBarItem.title = nil
        tab.tabBarItem.image = #imageLiteral(resourceName: "icn_tabbar_search")
        tab.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return tab
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // init view
        let splashViewController = SplashViewController()
        splashViewController.view.frame = view.frame
        self.view.addSubnode(splashViewController.node)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = UserDefaults.init().string(forKey: DefaultKeys.WW_SESSION_USER_TOKEN.rawValue) {
            UIApplication.shared.keyWindow?.setRootViewController(self.switchToHome(),
                                                                  options: UIWindow.TransitionOptions(direction: UIWindow.TransitionOptions.Direction.fade,
                                                                                                      style: UIWindow.TransitionOptions.Curve.linear))
        } else {
            let loginVC = LoginViewController()
            loginVC.view.frame = view.frame
            self.view.addSubnode(loginVC.scrollNode)
        }
    }
    
    func switchToHome() -> UIViewController {
        let tabbar = ASTabBarController()
        tabbar.viewControllers = [self.googleTab, self.newTab, self.sourceTab]
        tabbar.selectedIndex = 0
        tabbar.tabBar.tintColor = UIColor.red
        return tabbar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
