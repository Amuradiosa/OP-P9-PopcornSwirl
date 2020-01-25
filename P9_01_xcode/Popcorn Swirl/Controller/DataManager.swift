//
//  DataManager.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 24/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import Foundation

// This class will follow the singleton code design pattern to allow us to use a single instance of DataManager object to provide data throughout the whole application.
class DataManager {
    
    static let shared = DataManager()
    
    private init() {
        
    }
    
    
}
