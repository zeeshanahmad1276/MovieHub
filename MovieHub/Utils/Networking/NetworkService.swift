//
//  NetworkService.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import Foundation

class NetworkingService {
    
    private let urlCache: URLCache
    
    init() {
        let memoryCapacity = 50 * 1024 * 1024 // 50 MB
        let diskCapacity = 200 * 1024 * 1024 // 200 MB
        urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: nil)
    }
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: BaseURL.api + endpoint.path) else {
            completion(nil,NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(TMDBKeys.accessToken)"
        ]
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                // If there's an error and cached data is available, use it.
                if let cachedData = self.urlCache.cachedResponse(for: request as URLRequest)?.data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: cachedData)
                        completion(result, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, error)
                }
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "Data not found", code: -1, userInfo: nil))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
