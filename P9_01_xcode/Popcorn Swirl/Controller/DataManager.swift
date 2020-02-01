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
            let movie = MovieBrief(id: 486040195, title: "Movie \(i+1) is", category: "loading...", artWorkURL: "https://is4-ssl.mzstatic.com/image/thumb/Music/v4/33/ed/8e/33ed8eb0-4768-c14a-7e21-c421b9647e09/source/100x100bb.jpg")
            list.append(movie)
        }
       return list
    }()
    
    
}
