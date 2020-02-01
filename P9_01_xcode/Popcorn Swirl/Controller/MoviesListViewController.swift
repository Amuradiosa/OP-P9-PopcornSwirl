//
//  ViewController.swift
//  Popcorn Swirl
//
//  Created by Ahmad Murad on 24/01/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var dataSource: [MovieBrief] {
        return DataManager.shared.movieList
    }
    
    func loadData() {
        
        MovieService.getMovieList(term: "new") { (success, list) in
            if success, let list = list {
                DataManager.shared.movieList = list
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.presentNoDataAlert(title: "Oops, Something happened...",
                                   message: "Couldn't load movies for some reason please try again later")
            }
        }
    }
    
    func presentNoDataAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Got it", style: .cancel)
        
        alertController.addAction(dismissAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
    }
    
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFlowLayout.scrollDirection = .vertical
        navigationItem.title = "Movies"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails",
            let cell = sender as? ListCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell),
            let movieDetailViewController = segue.destination as? MovieDetailViewController {
            let movieBrief = dataSource[indexPath.item]
            movieDetailViewController.movieId = movieBrief.id
        }
    }

}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListCell", for: indexPath) as! ListCollectionViewCell
        let movieBrief = dataSource[indexPath.item]
        cell.populate(movieBrief: movieBrief)
        
        if let artworkData = movieBrief.artworkData,
            let artwork = UIImage(data: artworkData) {
            cell.setImage(image: artwork)
        } else if let imageURL = URL(string: movieBrief.artworkURL) {
            MovieService.getImage(imageUrl: imageURL, completion: { (success, imageData) in
                if success, let imageData = imageData,
                    let artwork = UIImage(data: imageData) {
                    movieBrief.artworkData = imageData
                    DispatchQueue.main.async {
                        cell.setImage(image: artwork)
                    }
                }
            })
        }
        return cell
    }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width
        print(w)
        print(CGSize(width: (w - 20)/2, height: 290))
        return CGSize(width: (w - 20)/2, height: 290)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}




