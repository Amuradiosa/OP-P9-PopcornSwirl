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
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    var releaseYears: [String] {
        var list = [String]()
        for i in 0...30 {
            guard let year = Calendar.current.dateComponents([.year], from: Date()).year else {
                fatalError("Failed to obtain year from Date object")
            }
            list.append(String(year - i))
        }
        return list
    }
    
    private var selected: IndexPath?
    
    var dataSource: [MovieBrief] {
        return DataManager.shared.movieList
    }
    
    func loadData(term: String) {
        MovieService.getMovieList(term: term) { (success, list) in
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
        loadData(term: releaseYears.first!)
    }
    
    func configure() {
        registerCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFlowLayout.scrollDirection = .vertical
        textBox.delegate = self
        dropDown.delegate = self
        dropDown.dataSource = self
        dropDown.isHidden = true
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "movieListCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails",
            let movieDetailViewController = segue.destination as? MovieDetailViewController {
            let movieBrief = dataSource[selected!.item]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath
        self.performSegue(withIdentifier: "showMovieDetails", sender: self)
    }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width
        return CGSize(width: (w - 20)/2, height: 290)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

// dropdown menu for the user to pick a release year of movies, it's defaulted to the latest.
extension MoviesListViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return releaseYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return releaseYears[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textBox.text = releaseYears[row]
        dropDown.isHidden = true
        loadData(term: releaseYears[row])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textBox {
            dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    
}


