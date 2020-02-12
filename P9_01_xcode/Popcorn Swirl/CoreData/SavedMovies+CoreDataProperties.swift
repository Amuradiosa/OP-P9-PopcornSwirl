//
//  SavedMovies+CoreDataProperties.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 08/02/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedMovies> {
        return NSFetchRequest<SavedMovies>(entityName: "SavedMovies")
    }

    @NSManaged public var artworkData: Data?
    @NSManaged public var artworkURL: String
    @NSManaged public var creationDate: Date
    @NSManaged public var genre: String
    @NSManaged public var id: Int64
    @NSManaged public var note: String?
    @NSManaged public var status: Bool
    @NSManaged public var title: String

}
