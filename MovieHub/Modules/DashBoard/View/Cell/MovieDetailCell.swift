//
//  MovieDetailCell.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class MovieDetailCell:BaseTableCell {
    
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let sublabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 14, weight: .regular)
        return label
    }()
    
    private let descLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .fixelText(size: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let rateStarView:RatingStarView = {
        let view = RatingStarView()
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        self.selectedBackgroundView = UIView()
        self.backgroundColor = .appDark
        subviews(label,descLabel,rateStarView)
        label.fillHorizontally(padding: 16).top(10).sizeToFit()
        descLabel.fillHorizontally(padding: 16).top(60).bottom(40)
        rateStarView.height(16).fillHorizontally(padding: 16).bottom(8)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func config(movie:Movie) {
        let genres    = movie.genres?.compactMap({$0.name}).joined(separator: ", ")
        let date      = movie.year
        let time      = movie.movieTime()
        self.label.text = "\(genres ?? ""). [\(date)] \(time)"
        self.descLabel.text = movie.overview
        self.rateStarView.currentRating = Int(movie.voteAverage ?? 0)
    }
}
