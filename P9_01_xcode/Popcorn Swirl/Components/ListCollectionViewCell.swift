//
//  ListCollectionViewCell.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 29/01/2020.
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
    
    func setImage(image: UIImage?) {
        artWorkImageView.image = image
    }
    
}
