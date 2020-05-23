//
//  CoreDataManager.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 02/02/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
  
  static let shared = CoreDataManager()
  
  private init() {
  }
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var fetchedRC: NSFetchedResultsController<SavedMovies>!
  
  func refreshWith(watchedMoviesList: Bool) {
    let request = SavedMovies.fetchRequest() as NSFetchRequest<SavedMovies>
    request.predicate = NSPredicate(format: "status = %@", NSNumber(value: watchedMoviesList))
    
    let sort = NSSortDescriptor(key: #keyPath(SavedMovies.creationDate), ascending: true)
    request.sortDescriptors = [sort]
    fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    do {
      try fetchedRC.performFetch()
    } catch let error as NSError {
      print("Couldn't fetch. \(error), \(error.userInfo)")
    }
  }
  
}

extension CoreDataManager {
  
  func isThisMovieAlreadySaved(movieId: Int64) -> SavedMovies? {
    let request = SavedMovies.fetchRequest() as NSFetchRequest<SavedMovies>
    request.predicate = NSPredicate(format: "id == %d", movieId)
    do {
      return try context.fetch(request).first
    } catch let error as NSError {
      print("could not fetch. \(error), \(error.userInfo)")
    }
    return nil
  }
}
