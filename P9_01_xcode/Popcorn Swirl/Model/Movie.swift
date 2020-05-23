//
//  Movie.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 26/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import Foundation

// This class will be serving the detailed view controller of a movie
// subclass of the MovieBrief - to hold all the info
class Movie: MovieBrief {
  
  var releaseDate: String?
  var longDescription: String?
  // Property to take the user to the source
  var sourceURL: String
  
  init(id: Int64, title: String, category: String, artWorkURL: String, sourceURL: String) {
    self.sourceURL = sourceURL
    super.init(id: id, title: title, category: category, artWorkURL: artWorkURL)
  }
  
}
