//
//  DataManager.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 24/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import Foundation

// The data manager will be responsible for holding the data and providing it when needed for the UI of the app.
class DataManager {
    
    // This class will follow the singleton code design pattern to allow us to use a single instance of DataManager object to provide data throughout the whole application.
    static let shared = DataManager()
    
    private init() {
    }
    
    // Sample data to represent the movie list
    lazy var movieList: [MovieBrief] = {
        var list = [MovieBrief]()
        
        for i in 0..<10 {
            let movie = MovieBrief(id: 486040195, title: "Movie is", category: "loading...", artWorkURL: "")
            list.append(movie)
        }
       return list
    }()
    
}
