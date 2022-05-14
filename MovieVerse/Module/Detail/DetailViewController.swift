//
//  DetailViewController.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import UIKit
import Kingfisher

protocol DetailViewControllerProtocol: AnyObject {
    
    func getMovieId() -> Int?
    func setMovieDetail(image: String, title: String, body: String, link: String, releaseDate: String, rating: String)
    func setCollectionView()
    func reloadCollectionView()
    
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var imdbLinkImg: UIImageView!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: DetailPresenterProtocol!
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    
    func getMovieId() -> Int? {
        return movieId
    }
    
    func setMovieDetail(image: String, title: String, body: String, link: String, releaseDate: String, rating: String) {
        movieImg.kf.setImage(with: URL(string: image))
        titleLbl.text = title
        bodyLbl.text = body
        imdbLinkImg.image = UIImage(named: "imdbIcon")
        releaseDateLbl.text = releaseDate
        ratingLbl.text = rating
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SimilarMovieCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMovieCell")
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCell", for: indexPath) as! SimilarMovieCell
        
        if let movie = presenter.getSimilarMovie(indexPath.row) {
            cell.cellPresenter = SimilarMovieCellPresenter(view: cell, similarMovie: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(row: indexPath.row)
    }
}
