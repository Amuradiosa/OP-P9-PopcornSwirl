//
//  MovieDetailViewController.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 30/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieId: Int64!
    private var movie: Movie?
    // private var ad: Advertisment?
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    
    @IBOutlet weak var bookmarkOutlet: UIButton!
    @IBOutlet weak var addToWatchedOutlet: UIButton!
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addToWatchedButtonTapped(_ sender: UIButton) {
    }

    @IBAction func storeButtonTapped(_ sender: Any) {
        print(movie!.sourceURL)
        openURL(sourceUrl: movie!.sourceURL)
    }
    
    @IBAction func adViewTapped(_ sender: Any) {
        // ad resource code here
    }
    
    func openURL(sourceUrl: String?) {
        if let sourceUrl = sourceUrl, let url = URL(string: sourceUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            presentNoDataAlert(title: "Oops, Something happened..", message: "Can't take you to the source")
        }
    }
    
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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
