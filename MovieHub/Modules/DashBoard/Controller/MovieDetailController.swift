//
//  MovieDetailController.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class MovieDetailController:BaseViewController {
    
    public var movie:Movie? {
        didSet {
            getDetail(with: movie)
        }
    }
    
    private let networkingService = NetworkingService()
    private let detailView        = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
    }
}

extension MovieDetailController {
    
    func getDetail(with movie: Movie?) {
        guard let movie = movie,let id = movie.id else {
            self.showAlert(title: "MovieHub", message: "Something went wrong", actionTitle: "Ok")
            return
        }
        networkingService.fetchData(from: .movieDetail(id: id)) { (movie: Movie?, error: Error?) in
            guard let movie = movie,error == nil else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: error?.localizedDescription, actionTitle: "Ok")
                }
                return
            }
            self.detailView.movie = movie
        }
    }
    
    
}


extension MovieDetailController {
    
    func setupViews() {
        view.subviews(detailView)
        detailView.fillContainer()
    }
    
    func setupNavBar() {
        navigationItem.title = movie?.originalTitle
    }
    
}
