//
//  BaseTableCell.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import Foundation
import UIKit


class BaseTableCell:UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .appDark
    }
    
}



