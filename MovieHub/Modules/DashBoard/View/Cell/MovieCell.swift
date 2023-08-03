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
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        setupShadow()
        
        subviews(posterImage)
        posterImage.fillContainer()
    }
    
    func config(movie:Movie) {
        loadImageFromCacheOrAPI(posterPath: movie.posterPath, url: movie.posterURL)
    }
    
    func loadImageFromCacheOrAPI(posterPath:String,url:URL) {
        if let cachedImage = ImageCache.shared.image(forKey: posterPath) {
            // Image is cached, use it
            posterImage.image = cachedImage
        } else {
            // Image not in cache, check if it exists in app directory
            if let localImage = loadImageFromDocumentsDirectory(withName: posterPath) {
                // Image exists in app directory, use it and cache it
                posterImage.image = localImage
                ImageCache.shared.setImage(localImage, forKey: posterPath)
            } else {
                // Image not in app directory, download it from the API
                downloadImageFromAPI(posterPath: posterPath, posterURL: url)
            }
        }
    }
    
    func downloadImageFromAPI(posterPath:String,posterURL:URL) {
        posterImage.image = nil
        let task = URLSession.shared.dataTask(with: posterURL) { data, response, error in
            if let error = error {
                self.posterImage.image = UIImage(named: "placeholder-poster")
                print("Error fetching movie poster: \(error.localizedDescription)")
                return
            }
            if let data = data, let posterImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImage.image = posterImage
                    ImageCache.shared.setImage(posterImage, forKey: posterPath)
                    posterImage.saveImageToDocumentsDirectory(withName: posterPath)
                }
            } else {
                self.posterImage.image = UIImage(named: "placeholder-poster")
            }
        }
        task.resume()
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

