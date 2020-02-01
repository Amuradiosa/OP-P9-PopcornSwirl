//
//  MovieBrief.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 24/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import Foundation

// This class object purpose is to hold info for Movies list
class MovieBrief {
    
    // an iTunes id of a movie to help us looking up more details of that movie in the iTunes store
    var id: Int64
    var title: String
    var genre: String
    var artworkURL: String
    // a property to store the actual image data
    var artworkData: Data?
    
    init(id: Int64, title: String, category: String, artWorkURL: String) {
        self.id = id
        self.title = title
        self.genre = category
        self.artworkURL = artWorkURL
    }
    
}
