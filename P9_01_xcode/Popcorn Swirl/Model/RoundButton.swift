//
//  RoundButton.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 16/02/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit

struct RoundButton {
  
  private var button: UIButton?
  
  mutating func setButton(_ button: UIButton) {
    self.button = button
  }
  
  func roundButton() {
    if let newButton = button {
      newButton.layer.cornerRadius = 15
      newButton.layer.masksToBounds = true
    }
  }
}
