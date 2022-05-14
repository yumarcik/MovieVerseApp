//
//  HomeViewController.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 30.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    
    func getMovieId() -> Int?
    func setupTableView()
    func setupCollectionView()
    func reloadTableView()
    func reloadCollectionView()
}

class HomeViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    var presenter: HomePresenterProtocol!
    private let searchController = UISearchController(searchResultsController: SearchResultViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false

//        self.navigationController?.navigationBar.prefersLargeTitles = false
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
    }
    
} 

extension HomeViewController: HomeViewControllerProtocol {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func getMovieId() -> Int? {
        return 1
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        if let movie = presenter.getNowPlayingMovie(indexPath.row) {
            cell.cellPresenter = MovieCellPresenter(view: cell, movies: movie)
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        
        if let movie = presenter.getUpcomingMovie(indexPath.row) {
            cell.cellPresenter = SliderCellPresenter(view: cell, movies: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
