//
//  BaseView.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class BaseView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
}
