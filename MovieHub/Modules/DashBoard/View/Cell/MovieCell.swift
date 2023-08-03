//
//  MovieCell.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class MovieCell:BaseCollectionCell {
    
    lazy var posterImage:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .appDark
        iv.image = UIImage(named: "poster-placeholder")
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        setupShadow()
        
        subviews(posterImage)
        posterImage.fillContainer()
    }
    
    func config(movie:Movie) {
        if let posterPath = movie.posterPath, let url = movie.posterURL {
            loadImageFromCacheOrAPI(posterPath: posterPath, url: url,placeHolder: "poster-placeholder") { image in
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        }
        
    }
    
}



class ActivityFooterView: UICollectionReusableView {
    
    static var identifier:String {
        return String(describing: self)
    }
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.backgroundColor = .clear
        activity.color = .white
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subviews(activityIndicator)
        activityIndicator.fillContainer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        subviews(activityIndicator)
        activityIndicator.fillContainer()
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

