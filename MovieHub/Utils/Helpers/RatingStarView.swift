//
//  RatingStarView.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/4/23.
//

import UIKit

import UIKit

class RatingStarView: UIView {

    let maxStars: Int = 10
    var currentRating: Int = 0 {
        didSet {
            updateStars()
        }
    }
    
    var ivs:[UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }

    
    private func setupStars() {
        let starSize: CGFloat = 16
        let spacing: CGFloat = 2.0

        for index in 0..<maxStars {
            let starImageView = UIImageView()
            starImageView.tag = index
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = UIImage(systemName: "star")
            starImageView.tintColor = .yellow
            self.subviews(starImageView)
            ivs.append(starImageView)
            starImageView.left(CGFloat(index) * (starSize + spacing)).centerVertically().height(starSize).width(starSize)
        }

        updateStars()
    }


    private func updateStars() {
        for (index, starImageView) in self.subviews.enumerated() {
            if let imageView = starImageView as? UIImageView {
                let imageName = index < currentRating ? "star.fill" : "star"
                imageView.image = UIImage(systemName: imageName)
            }
        }
    }
}
