//
//  MovieHubTests.swift
//  MovieHubTests
//
//  Created by Macbook 5 on 8/4/23.
//

import XCTest

final class MovieHubTests: XCTestCase {
    
    var mockNetworkingService: MockNetworkingService!
    var moviesListController:MoviesListController!
    
    override func setUpWithError() throws {
        // Create a mock NetworkingService instance
        moviesListController = MoviesListController()
        mockNetworkingService = MockNetworkingService()
        moviesListController.networkingService = mockNetworkingService
        moviesListController.viewDidLoad()
        
        // Load the view to trigger viewDidLoad and other lifecycle methods
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        moviesListController = nil
        mockNetworkingService = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        guard let moviesData = moviesJSON.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }
        let movieListModel = try? JSONDecoder().decode(MovieListModel.self, from: moviesData)
        moviesListController.getMovies(with: 1)
        
        XCTAssertEqual(moviesListController.movieListModel, movieListModel, "MovieListModel should be updated correctly.")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class MockNetworkingService: NetworkingService {
    
    var error: Error?
    
    override func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (T?, Error?) -> Void) {
        if let moviesData = moviesJSON.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: moviesData)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        } else if let error = error {
            completion(nil, error)
        } else {
            // Provide a default implementation for the case when no mock data is provided.
            fatalError("Mock data not provided.")
        }
    }
}


let moviesJSON =
"""
{
    "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/nHf61UzkfFno5X1ofIhugCPus2R.jpg",
            "genre_ids": [
                35,
                12,
                14
            ],
            "id": 346698,
            "original_language": "en",
            "original_title": "Barbie",
            "overview": "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.",
            "popularity": 3304.505,
            "poster_path": "/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
            "release_date": "2023-07-19",
            "title": "Barbie",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 2195
        },
        {
            "adult": false,
            "backdrop_path": "/yF1eOkaYvwiORauRCPWznV9xVvi.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 298618,
            "original_language": "en",
            "original_title": "The Flash",
            "overview": "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?",
            "popularity": 2768.382,
            "poster_path": "/rktDFPbfHfUbArZ6OOOKsXcv0Bm.jpg",
            "release_date": "2023-06-13",
            "title": "The Flash",
            "video": false,
            "vote_average": 6.9,
            "vote_count": 1957
        },
        {
            "adult": false,
            "backdrop_path": "/2vFuG6bWGyQUzYS9d69E5l85nIz.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 667538,
            "original_language": "en",
            "original_title": "Transformers: Rise of the Beasts",
            "overview": "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.",
            "popularity": 2705.838,
            "poster_path": "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
            "release_date": "2023-06-06",
            "title": "Transformers: Rise of the Beasts",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 2267
        },
        {
            "adult": false,
            "backdrop_path": "/znUYFf0Sez5lUmxPr3Cby7TVJ6c.jpg",
            "genre_ids": [
                12,
                10751,
                14,
                10749
            ],
            "id": 447277,
            "original_language": "en",
            "original_title": "The Little Mermaid",
            "overview": "The youngest of King Triton’s daughters, and the most defiant, Ariel longs to find out more about the world beyond the sea, and while visiting the surface, falls for the dashing Prince Eric. With mermaids forbidden to interact with humans, Ariel makes a deal with the evil sea witch, Ursula, which gives her a chance to experience life on land, but ultimately places her life – and her father’s crown – in jeopardy.",
            "popularity": 2106.888,
            "poster_path": "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg",
            "release_date": "2023-05-18",
            "title": "The Little Mermaid",
            "video": false,
            "vote_average": 6.5,
            "vote_count": 1364
        },
        {
            "adult": false,
            "backdrop_path": "/iEFuHjqrE059SmflBva1JzDJutE.jpg",
            "genre_ids": [
                16,
                10751,
                28,
                14,
                10749
            ],
            "id": 496450,
            "original_language": "fr",
            "original_title": "Miraculous - le film",
            "overview": "A life of an ordinary Parisian teenager Marinette goes superhuman when she becomes Ladybug. Bestowed with magical powers of creation, Ladybug must unite with her opposite, Cat Noir, to save Paris as a new villain unleashes chaos unto the city.",
            "popularity": 1961.565,
            "poster_path": "/bBON9XO9Ek0DjRwMBnJNCwC96Cd.jpg",
            "release_date": "2023-07-05",
            "title": "Miraculous: Ladybug & Cat Noir, The Movie",
            "video": false,
            "vote_average": 8.1,
            "vote_count": 259
        },
        {
            "adult": false,
            "backdrop_path": "/uj2duAkn6zUmRSbjyEr7XUeIWsJ.jpg",
            "genre_ids": [
                16,
                28,
                27
            ],
            "id": 1083862,
            "original_language": "ja",
            "original_title": "バイオハザード：デスアイランド",
            "overview": "In San Francisco, Jill Valentine is dealing with a zombie outbreak and a new T-Virus, Leon Kennedy is on the trail of a kidnapped DARPA scientist, and Claire Redfield is investigating a monstrous fish that is killing whales in the bay. Joined by Chris Redfield and Rebecca Chambers, they discover the trail of clues from their separate cases all converge on the same location, Alcatraz Island, where a new evil has taken residence and awaits their arrival.",
            "popularity": 1734.637,
            "poster_path": "/qayga07ICNDswm0cMJ8P3VwklFZ.jpg",
            "release_date": "2023-06-22",
            "title": "Resident Evil: Death Island",
            "video": false,
            "vote_average": 7.9,
            "vote_count": 353
        },
        {
            "adult": false,
            "backdrop_path": "/5YZbUmjbMa3ClvSW1Wj3D6XGolb.jpg",
            "genre_ids": [
                878,
                12,
                28
            ],
            "id": 447365,
            "original_language": "en",
            "original_title": "Guardians of the Galaxy Vol. 3",
            "overview": "Peter Quill, still reeling from the loss of Gamora, must rally his team around him to defend the universe along with protecting one of their own. A mission that, if not completed successfully, could quite possibly lead to the end of the Guardians as we know them.",
            "popularity": 1813.797,
            "poster_path": "/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg",
            "release_date": "2023-05-03",
            "title": "Guardians of the Galaxy Vol. 3",
            "video": false,
            "vote_average": 8.1,
            "vote_count": 3805
        },
        {
            "adult": false,
            "backdrop_path": "/iJ0UZaC7XW7BUpRQ7OLPZSms8Ou.jpg",
            "genre_ids": [
                28,
                878,
                53
            ],
            "id": 813477,
            "original_language": "ja",
            "original_title": "シン・仮面ライダー",
            "overview": "A man forced to bear power and stripped of humanity. A woman skeptical of happiness. Takeshi Hongo, an Augmentation made by SHOCKER, and Ruriko Midorikawa, a rebel of the organization, escape while fighting off assassins. What’s justice? What’s evil? Will this violence end? Despite his power, Hongo tries to remain human. Along with freedom, Ruriko has regained a heart. What paths will they choose?",
            "popularity": 1404.968,
            "poster_path": "/9dTO2RygcDT0cQkawABw4QkDegN.jpg",
            "release_date": "2023-03-17",
            "title": "Shin Kamen Rider",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 65
        }
    ],
    "total_pages": 39396,
    "total_results": 787909
}
"""
