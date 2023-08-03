//
//  EndPoints.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import Foundation

enum Endpoint {
    
    case popularMovies(page: Int)
    case movieDetail(id: Int)

    var path: String {
        switch self {
        case .popularMovies(let page):
            return "/movie/popular?language=en-US&page=\(page)"
        case .movieDetail(let id):
            return "/movie/\(id)?language=en-US"
        }
    }
}
