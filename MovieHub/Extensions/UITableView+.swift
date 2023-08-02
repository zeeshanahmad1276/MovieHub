//
//  UITableView+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit


extension UITableView {
    
    func registerCell(ofType cellType: UITableViewCell.Type) {
        let name = String(describing: cellType.self)
        register(cellType, forCellReuseIdentifier: name)
    }
    
    func dequeueTypedCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self),
        for: indexPath) as! T
    }
}
