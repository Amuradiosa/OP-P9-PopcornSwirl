//
//  MovieService.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 24/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import Foundation

// this helper controller will be responsible for external communications - with iTunes specifically
class MovieService {
  
  private struct API {
    private static let base = "https://itunes.apple.com/"
    private static let search = API.base + "search"
    private static let lookup = API.base + "lookup"
    
    static let searchURL = URL(string: API.search)!
    static let lookupURL = URL(string: API.lookup)!
  }
  
  private static func createRequest(url: URL, params: [String: Any]) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let body = params.map {"\($0)=\($1)"}
      .joined(separator: "&")
    print(body)
    request.httpBody = body.data(using: .utf8)
    return request
  }
  
  private static func createSearchRequest(term: String) -> URLRequest {
    let params = ["attribute": "releaseYearTerm", "term": term, "entity": "movie"]
    return createRequest(url: API.searchURL, params: params)
  }
  
  private static func createLookupRequest(id: Int64) -> URLRequest {
    let params = ["id": id, "entity": "movie"] as [String : Any]
    return createRequest(url: API.lookupURL, params: params)
  }
  
  static func getMovieList(term: String, completion: @escaping (Bool, [MovieBrief]?) -> Void) {
    let session = URLSession(configuration: .default)
    let request = createSearchRequest(term: term)
    _ = session.dataTask(with: request) { (data, response, error) in
      if let data = data, error == nil {
        // JSON is an object that converts between JSON and the equivalent Foundation objects.
        if let response = response as? HTTPURLResponse, response.statusCode == 200,
          let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
          let results = responseJSON["results"] as? [AnyObject] {
          var list = [MovieBrief]()
          for i in 0..<results.count {
            guard let movie = results[i] as? [String: Any] else {
              continue
            }
            if let id = movie["trackId"] as? Int64,
              let title = movie["trackName"] as? String,
              let category = movie["primaryGenreName"] as? String,
              let artWorkURL = movie["artworkUrl100"] as? String {
              let movieBrief = MovieBrief(id: id, title: title, category: category, artWorkURL: artWorkURL)
              list.append(movieBrief)
            }
          }
          completion(true, list)
        } else {
          completion(false, nil)
        }
      } else {
        completion(false, nil)
      }
    }.resume()
  }
  
  static func getMovie(id: Int64, completion: @escaping (Bool, Movie?) -> Void) {
    let session = URLSession(configuration: .default)
    let request = createLookupRequest(id: id)
    
    _ = session.dataTask(with: request) { (data, response, error) in
      if let data = data, error == nil {
        if let response = response as? HTTPURLResponse, response.statusCode == 200,
          let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
          let results = responseJSON["results"] as? [AnyObject] {
          if results.count == 1,
            let movieResults = results[0] as? [String: Any],
            let id = movieResults["trackId"] as? Int64,
            let title = movieResults["trackName"] as? String,
            let category = movieResults["primaryGenreName"] as? String,
            let artWorkURL = movieResults["artworkUrl100"] as? String,
            let sourceURL = movieResults["trackViewUrl"] as? String {
            let movie = Movie(id: id, title: title, category: category, artWorkURL: artWorkURL, sourceURL: sourceURL)
            movie.releaseDate = movieResults["releaseDate"] as? String
            movie.longDescription = movieResults["longDescription"] as? String
            completion(true, movie)
          } else {
            completion(false, nil)
          }
        } else {
          completion(false, nil)
        }
      } else {
        completion(false, nil)
      }
    }.resume()
  }
  
  static func getImage(imageUrl: URL, completion: @escaping (Bool, Data?) -> Void) {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: imageUrl) { (data, response, error) in
      if let data = data, error == nil,
        let response = response as? HTTPURLResponse, response.statusCode == 200 {
        completion(true, data)
      } else {
        completion(false, nil)
      }
    }
    task.resume()
  }
  
}
