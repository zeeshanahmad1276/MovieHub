//
//  MoviesListController.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class MoviesListController:BaseViewController {
    
    private let networkingService = NetworkingService()
    private let movieListView     = MovieListView()
    private var movieListModel    : MovieListModel?
    private let rightItemLabel    = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        getMovies(with: 1)
    }
   
    override func networkReachable(status: Bool) {
        super.networkReachable(status: status)
        didChangeConnectivity(online: status)
    }
    
}

extension MoviesListController {
    
    func setupViews() {
        movieListView.delegate = self
        view.subviews(movieListView)
        movieListView.fillContainer()
    }
    
    func setupNavBar() {
        navigationItem.title = "Popular Movies"
        rightItemLabel.text = ""
        rightItemLabel.textColor = .white
        rightItemLabel.font = .fixelText(size: 14, weight: .regular)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightItemLabel)
    }
    
    func didChangeConnectivity(online:Bool) {
        rightItemLabel.text = online ? "Online" : "Offline"
        rightItemLabel.textColor = online ? .appBlue : .appRed
        rightItemLabel.sizeToFit()
    }
    
}

extension MoviesListController {
    
    func getMovies(with page:Int) {
        networkingService.fetchData(from: .popularMovies(page: page)) { (movies: MovieListModel?, error: Error?) in
            guard let model = movies,error == nil else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: error?.localizedDescription, actionTitle: "Ok")
                }
                return
            }
            self.movieListModel = model
            self.movieListView.appendMovies(movies: model.movies)
        }
    }
}

extension MoviesListController:MovieListViewDelegate {
    
    func fetchNextPageIfAvailable() {
        if let movieListModel = movieListModel {
            let totalPage = movieListModel.totalPages
            let nextPage = movieListModel.page + 1
            if nextPage < totalPage {
                self.getMovies(with: nextPage)
            } else {
                self.showAlert(title: "Loaded", message: "All Popular Movies has been loaded", actionTitle: "Ok")
            }
        }
    }
    
    func didTapMoive(movie: Movie) {
        let detailVC = MovieDetailController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
