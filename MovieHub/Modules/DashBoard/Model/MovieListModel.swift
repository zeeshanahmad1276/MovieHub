//
//  MovieListModel.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import Foundation

struct MovieListModel: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie : Codable {
    let adult : Bool?
    let backdropPath : String?
    let belongsToCollection : BelongsToCollection?
    let budget : Int?
    let genres : [Genres]?
    let homepage : String?
    let id : Int?
    let imdbId : String?
    let originalLanguage : String?
    let originalTitle : String?
    let overview : String?
    let popularity : Double?
    let posterPath : String?
    let productionCompanies : [ProductionCompanies]?
    let productionCountries : [ProductionCountries]?
    let releaseDate : String?
    let revenue : Int?
    let runtime : Int?
    let spokenLanguages : [SpokenLanguages]?
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let voteAverage : Double?
    let voteCount : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        belongsToCollection = try values.decodeIfPresent(BelongsToCollection.self, forKey: .belongsToCollection)
        budget = try values.decodeIfPresent(Int.self, forKey: .budget)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imdbId = try values.decodeIfPresent(String.self, forKey: .imdbId)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        productionCompanies = try values.decodeIfPresent([ProductionCompanies].self, forKey: .productionCompanies)
        productionCountries = try values.decodeIfPresent([ProductionCountries].self, forKey: .productionCountries)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        spokenLanguages = try values.decodeIfPresent([SpokenLanguages].self, forKey: .spokenLanguages)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
    }

   
    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    var year:String {
       let date = self.releaseDate?.extractDate()
        return date?.toString() ?? ""
    }
    
    func movieTime() -> String {
        guard let runTime = runtime else {
            return ""
        }
        let hours = runTime / 60
        let remainingMinutes = runTime % 60
        let s = hours == 1 ? "" : "s"
        return "\(hours) hour\(s) \(remainingMinutes) mins"
    }
}


struct Genres : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct ProductionCompanies : Codable {
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case logo_path = "logo_path"
        case name = "name"
        case origin_country = "origin_country"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        logo_path = try values.decodeIfPresent(String.self, forKey: .logo_path)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin_country = try values.decodeIfPresent(String.self, forKey: .origin_country)
    }

}

struct ProductionCountries : Codable {
    let iso_3166_1 : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case iso_3166_1 = "iso_3166_1"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct SpokenLanguages : Codable {
    let english_name : String?
    let iso_639_1 : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case english_name = "english_name"
        case iso_639_1 = "iso_639_1"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        english_name = try values.decodeIfPresent(String.self, forKey: .english_name)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct  BelongsToCollection:Codable {
    let id:Int?
    let name:String?
    let poster_path:String?
    let backdrop_path:String?
   
}
