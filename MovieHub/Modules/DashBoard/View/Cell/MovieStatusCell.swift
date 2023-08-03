//
//  MovieStatusCell.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/4/23.
//

import UIKit

class MovieStatusCell:BaseTableCell {
    
    private let languageHeader:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 15, weight: .medium)
        label.textColor = .white
        label.text = "Languages:"
        return label
    }()
    
    private let langLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let statusHeader:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let linkHeader:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 15, weight: .medium)
        label.textColor = .white
        label.text = "Home Page:"
        return label
    }()
    
    private let linkButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .fixelText(size: 14, weight: .regular)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        self.selectedBackgroundView = UIView()
        self.backgroundColor = .appDark
        let half = (self.bounds.width - 32) * 0.5
        subviews(languageHeader,langLabel,statusHeader,linkButton,linkHeader)
        languageHeader.width(half).left(16).height(20).top(8)
        statusHeader.width(half).right(16).height(20).top(8)
        langLabel.width(half).left(16).top(38).bottom(64)
        linkHeader.width(half).left(16).height(20).bottom(30)
        linkButton.fillHorizontally(padding: 16).height(16).bottom(8)
        linkButton.addTarget(self, action: #selector(didTapOnLink), for: .touchUpInside)
        
    }
    
    func config(movie:Movie) {
        statusHeader.text = movie.status
        langLabel.text = movie.spokenLanguages?.compactMap({$0.english_name}).joined(separator: ",\n")
        linkButton.setTitle(movie.homepage, for: .normal)
    }
    
    @objc
    func didTapOnLink() {
        if let text = linkButton.titleLabel?.text,let url = URL(string: text) {
            UIApplication.shared.open(url)
        }
    }
}


