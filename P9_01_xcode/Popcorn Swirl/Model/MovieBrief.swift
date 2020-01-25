//
//  MovieBrief.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 24/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import Foundation

// This class object purpose is to hold info for Movies list
class MediaBrief {
    
    var id: Int
    var title: String
    var category: String
    var releaseYear: Int
    var artWorkURL: String
    
    var artWorkData: Data?
    
    init(id: Int, title: String, category: String, releaseYear: Int, artWorkURL: String) {
        self.id = id
        self.title = title
        self.category = category
        self.releaseYear = releaseYear
        self.artWorkURL = artWorkURL
    }
    
}
