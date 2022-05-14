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
    func moveToDetail(movieId: Int)
    func setupPageController(number: Int)
    func setupNavigationBar()
}

class HomeViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        searchResultVC.didUpdateText(text: text)

    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // Properties
    var presenter: HomePresenterProtocol!
    var searchView: SearchResultViewControllerProtocol!
    var searchResultVC = SearchResultRouter.createModule()
    private var searchController : UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
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
    
    func setupNavigationBar() {
        searchResultVC.homeView = self
        searchController = UISearchController(searchResultsController: searchResultVC)
        searchController!.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController!.searchBar.placeholder = "Search"
        searchController!.hidesNavigationBarDuringPresentation = true
        searchController!.definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Movies"
        navigationController?.navigationBar.tintColor = UIColor.red
        searchController?.automaticallyShowsScopeBar = false
        searchController?.isActive = true
        searchController?.searchBar.becomeFirstResponder()
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    
    func setupPageController(number: Int) {
        pageControl.numberOfPages = number
    }
    
    func moveToDetail(movieId: Int) {
        presenter.moveToDetail(movieId: movieId)
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


