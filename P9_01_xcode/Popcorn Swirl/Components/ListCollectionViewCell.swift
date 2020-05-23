//
//  ListCollectionViewCell2.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 08/02/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var artWorkImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  
  func populate(movieBrief: MovieBrief) {
    titleLabel.text = movieBrief.title
    categoryLabel.text = movieBrief.genre
  }
  
  func populateWith(savedMovies: SavedMovies) {
    titleLabel.text = savedMovies.title
    categoryLabel.text = savedMovies.genre
  }
  
  func setImage(image: UIImage?) {
    artWorkImageView.image = image
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
}
