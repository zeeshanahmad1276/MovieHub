//
//  MoviesListController.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit


class MoviesListController:BaseViewController {
    
    private let networkingService = NetworkingService()
    
    private var movieListModel:MovieListModel? 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies(with: 1)
    }
    
    
}

extension MoviesListController {
    
    func getMovies(with page:Int) {
        networkingService.fetchData(from: .popularMovies(page: page)) { (movies: MovieListModel?, error: Error?) in
            guard let movies = movies,error == nil else {
                return
            }
            print(movies)
        }
    }
    
}

extension MoviesListController {
    
    
}
