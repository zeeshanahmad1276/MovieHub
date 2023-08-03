//
//  AppPlaceHolderView.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class AppPlaceHolderView:BaseView {
    
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 18, weight: .medium)
        label.textColor = .white
        label.text = "Unable to fetch movies\nPlease try again!"
        label.textAlignment = .center
        return label
    }()
    
    let refresh:UIButton = {
        let iv = UIButton()
        iv.backgroundColor = .appBlue
        iv.setTitle("Refresh", for: .normal)
        iv.titleLabel?.font = .fixelText(size: 16, weight: .black)
        iv.setTitleColor(.white, for: .normal)
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        subviews(label,refresh)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.fillHorizontally(padding: 16).bottom(self.frame.height * 0.52)
        refresh.fillHorizontally(padding: 16).height(44).top(self.frame.height * 0.52)
    }
}
