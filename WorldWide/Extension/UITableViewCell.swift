//
//  ExUITableViewCell.swift
//  WorldWide
//
//  Created by Hoang Trong Anh on 3/12/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static func registerNibIn(_ tableView: UITableView) {
        let identifier = String(describing: self)
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    static func dequeueReusableCellFrom<T: UITableViewCell>(_ tableView: UITableView, indexPath: IndexPath) -> T {
        let identifier = String(describing: self)
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }
        return T()
    }
    
}
