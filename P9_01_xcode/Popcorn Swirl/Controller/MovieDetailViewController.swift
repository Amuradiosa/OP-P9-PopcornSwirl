//
//  MovieDetailViewController.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 30/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit
import CoreData

protocol ModalHandler {
    func modalDismissed()
}

class MovieDetailViewController: UIViewController {
    
    var movieId: Int64!
    var movieNote: String?
    private var movie: Movie?
    var delegate: ModalHandler?
    // private var ad: Advertisment?
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    
    @IBOutlet weak var bookmarkOutlet: UIButton!
    @IBOutlet weak var addToWatchedOutlet: UIButton!
    @IBOutlet weak var addNoteOutlet: UIButton!
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        updateBookmarkOutlet()
        if bookmarkOutlet.isSelected || addToWatchedOutlet.isSelected {
            createOrUpdateMovie(status: false, note: nil)
        } else {
            deleteMovie()
        }
    }
    
    @IBAction func addToWatchedButtonTapped(_ sender: UIButton) {
        updateAddToWatchOutlet()
        if bookmarkOutlet.isSelected || addToWatchedOutlet.isSelected {
            createOrUpdateMovie(status: true, note: nil)
        } else {
            deleteMovie()
        }
    }
    
    @IBAction func storeButtonTapped(_ sender: Any) {
        print(movie!.sourceURL)
        openURL(sourceUrl: movie!.sourceURL)
    }
    
    @IBAction func addNoteButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func adViewTapped(_ sender: Any) {
        // ad resource code here
    }
    
    func updateBookmarkOutlet() {
        bookmarkOutlet.isSelected = !bookmarkOutlet.isSelected
        bookmarkOutlet.tintColor = bookmarkOutlet.isSelected ? UIColor.systemPink : UIColor.darkGray
        if addToWatchedOutlet.isSelected {
            addToWatchedOutlet.isSelected = false
            addToWatchedOutlet.tintColor = UIColor.darkGray
        }
        updateNoteOutlet()
    }
    
    func updateAddToWatchOutlet() {
        addToWatchedOutlet.isSelected = !addToWatchedOutlet.isSelected
        addToWatchedOutlet.tintColor = addToWatchedOutlet.isSelected ? UIColor.systemPink : UIColor.darkGray
        updateNoteOutlet()
        if bookmarkOutlet.isSelected {
            bookmarkOutlet.isSelected = false
            bookmarkOutlet.tintColor = UIColor.darkGray
        }
    }
    
    func updateNoteOutlet() {
        addNoteOutlet.backgroundColor = addToWatchedOutlet.isSelected ? UIColor.systemPink : UIColor.darkGray
        if addToWatchedOutlet.isSelected == true {
            addNoteOutlet.setTitle("Add a Note", for: .normal)
            addNoteOutlet.titleLabel?.font = addNoteOutlet.titleLabel?.font.withSize(24)
            addNoteOutlet.isEnabled = true
        } else {
            addNoteOutlet.setTitle("Add movie to Watched list to attach a note to it", for: .normal)
            addNoteOutlet.titleLabel?.font = addNoteOutlet.titleLabel?.font.withSize(15)
            addNoteOutlet.isEnabled = false
        }
    }
    
    func openURL(sourceUrl: String?) {
        if let sourceUrl = sourceUrl, let url = URL(string: sourceUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            presentNoDataAlert(title: "Oops, Something happened..", message: "Can't take you to the source")
        }
    }
    
    // to update UI when opening the movie details from any root screen
    func updateUI() {
        if let alreadySavedMovie = CoreDataManager.shared.isThisMovieAlreadySaved(movieId: movieId) {
            alreadySavedMovie.status ? updateAddToWatchOutlet() : updateBookmarkOutlet()
            
        }
    }
    
    func deleteMovie() {
        if let alreadySavedMovie = CoreDataManager.shared.isThisMovieAlreadySaved(movieId: movieId) {
        // delete movie
            CoreDataManager.shared.context.delete(alreadySavedMovie)
            CoreDataManager.shared.appDelegate.saveContext()
        }
    }
    
    // status = false means movie is bookmarked, status = true means movie is add to watched list
    func createOrUpdateMovie(status: Bool, note: String?) {
        if let alreadySavedMovie = CoreDataManager.shared.isThisMovieAlreadySaved(movieId: movieId) {
            // update movie
            alreadySavedMovie.status = status
            if note != nil { alreadySavedMovie.note = note }
            CoreDataManager.shared.appDelegate.saveContext()
        } else {
            // create movie
            let movie = SavedMovies(entity: SavedMovies.entity(), insertInto: CoreDataManager.shared.context)
            
            movie.id = self.movie!.id
            movie.title = self.movie!.title
            movie.genre = self.movie!.genre
            movie.artworkURL = self.movie!.artworkURL
            movie.artworkData = self.movie?.artworkData
            movie.status = status
            movie.creationDate = Date()
            if note != nil { movie.note = note }
            CoreDataManager.shared.appDelegate.saveContext()
        }
    }
    
    /* func addNoteAlert() {

            addNote(UITextView.text!)
       }
    */
    
    /* func addNote(_ text: UIText) {
            updateCoreData()
       }
     */
    
    /* func updateCoreData() {
            // fetching the corresponding movie object and add a note to it, or update movie object, or deleting it if unbookmarked or unwatched
            deleteMovie()
        }
     */
    
    /* func deleteMovie() {
     
        }
     */
    
    /* extension className: NSFetchedResultsControllerDelegate {
            // to handle concurrency between coredata and UI
     }
     
     */
    
    func presentNoDataAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Got it", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    func loadData() {
        MovieService.getMovie(id: movieId) { (success, movie) in
            if success, let movie = movie {
                self.movie = movie
                //self.ad = DataManager.shared.adFor(movie: movie)
                DispatchQueue.main.async {
                    self.populateMovie()
                    self.populateAd()
                }
            } else {
                self.presentNoDataAlert(title: "Oops, Something happened..", message: "Couldn't load movie details")
            }
        }
    }
    
    func populateMovie() {
        guard let movie = self.movie else {
            return
        }
        
        titleLabel.text = movie.title
        genreLabel.text = movie.genre
        // FIXME: - get the first four charachters for the release year
        releaseYearLabel.text = movie.releaseDate
        longDescriptionTextView.text = movie.longDescription
        
        if let imageUrl = URL(string: movie.artworkURL) {
            MovieService.getImage(imageUrl: imageUrl) { (success, imageData) in
                if success, let imageData = imageData ,
                    let artwork = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.artworkImageView.image = artwork
                    }
                }
            }
        }
    }
    
    func populateAd() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configure()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    func configure() {
        updateNoteOutlet()
        updateUI()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        delegate?.modalDismissed()
    }
}
