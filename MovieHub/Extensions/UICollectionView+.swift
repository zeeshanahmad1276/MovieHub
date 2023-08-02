//
//  UICollectionView+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

extension UICollectionView {
    
    func registerCell(ofType cellType: UICollectionViewCell.Type) {
        let name = String(describing: cellType.self)
        register(cellType, forCellWithReuseIdentifier: name)
    }
    
    func dequeueTypedCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                   for: indexPath) as! T
    }
}
