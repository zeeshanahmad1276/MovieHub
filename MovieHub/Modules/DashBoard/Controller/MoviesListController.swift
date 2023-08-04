//
//  MoviesListController.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class MoviesListController:BaseViewController {
    
    public  var networkingService = NetworkingService() // var for unit/ui test
    private let movieListView     = MovieListView()
    public  var movieListModel    : MovieListModel?
    private let rightItemLabel    = UILabel()
    public  let placeHolder       = AppPlaceHolderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        initPlaceHolder()
        getMovies(with: 1)
    }
   
    override func networkReachable(status: Bool) {
        super.networkReachable(status: status)
        didChangeConnectivity(online: status)
        if self.movieListModel == nil {
            self.getMovies(with: 1)
        }
    }
}

extension MoviesListController {
    
    func setupViews() {
        movieListView.delegate = self
        view.subviews(movieListView,placeHolder)
        movieListView.fillContainer()
        placeHolder.fillContainer()
    }
    
    func setupNavBar() {
        navigationItem.title = "Popular Movies"
        rightItemLabel.text = "Status"
        rightItemLabel.textColor = .white
        rightItemLabel.font = .fixelText(size: 14, weight: .regular)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightItemLabel)
    }
    
    func didChangeConnectivity(online:Bool) {
        rightItemLabel.text = online ? "Online" : "Offline"
        rightItemLabel.textColor = online ? .appBlue : .appRed
    }
    
}

extension MoviesListController {
    
    func getMovies(with page:Int) {
        startAnimating(page: page)
        networkingService.fetchData(from: .popularMovies(page: page)) { (movies: MovieListModel?, error: Error?) in
            self.stopAnimating()
            guard let model = movies,error == nil else {
                DispatchQueue.main.async {
                    self.placeHolder.isHidden = page == 1 ? false : true // Hide when any page is here
                    self.showAlert(title: "Error", message: error?.localizedDescription, actionTitle: "Ok")
                }
                return
            }
            self.movieListModel = model
            self.movieListView.appendMovies(movies: model.movies)
            DispatchQueue.main.async {
                self.placeHolder.isHidden = true
            }
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

extension MoviesListController {
    
    func initPlaceHolder() {
        placeHolder.isHidden = true
        placeHolder.refresh.addTarget(self,
                                      action: #selector(didTapRefresh),
                                      for: .touchUpInside)
    }
    
    @objc
    func didTapRefresh() {
        self.getMovies(with: 1)
    }
    
    
    func startAnimating(page:Int) {
        guard page == 1 else {return}
        DispatchQueue.main.async {
            self.activitIndicator.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.activitIndicator.stopAnimating()
        }
    }
    
}
