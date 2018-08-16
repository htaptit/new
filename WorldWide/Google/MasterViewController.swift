//
//  InitViewController.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let tabbarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            appDelegate.window?.rootViewController = tabbarController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
