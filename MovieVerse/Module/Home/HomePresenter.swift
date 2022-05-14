//
//  HomePresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 30.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func didSelectRowAt(index: Int)
    func moveToDetail(movieId: Int)
    func getNowPlayingMovie(_ index: Int) -> Movies?
    func getUpcomingMovie(_ index: Int) -> Movies?
    func numberOfItemsInSection() -> Int
    func didSelectItemAt(index: Int)
}

final class HomePresenter: HomePresenterProtocol {
    
    func didSelectItemAt(index: Int) {
        router.navigate(.detail(movieId: upcomingMovies[index].id!))
    }
    
    func getUpcomingMovie(_ index: Int) -> Movies? {
        return upcomingMovies[safe: index]
    }
    
    func numberOfItemsInSection() -> Int {
        return upcomingMovies.count
    }
    
    func getNowPlayingMovie(_ index: Int) -> Movies? {
        return nowPlayingMovies[safe: index]
    }
    
    func moveToDetail(movieId: Int) {
        router.navigate(.detail(movieId: movieId))
    }
    
    func viewDidLoad() {
        view?.setupCollectionView()
        view?.setupTableView()
        view?.setupNavigationBar()
        interactor.getUpcomingMovies()
        interactor.getNowPlayingMovies()
    }
    
    func numberOfItems() -> Int {
        return nowPlayingMovies.count
    }
    
    func didSelectRowAt(index: Int) {
        router.navigate(.detail(movieId: nowPlayingMovies[index].id!))
    }

    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    private var nowPlayingMovies: [Movies] = []
    private var upcomingMovies: [Movies] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func getNowPlayingMoviesSuccess(result: MoviesResult) {
        
        switch result {
            
        case .success(let moviesResult):
            nowPlayingMovies = moviesResult.results ?? []
            view?.reloadTableView()
        case .failure(let error):
            print(error)
            
        }
    }
    
    func getUpcomingMoviesSuccess(result: MoviesResult) {
        
        switch result {
            
        case .success(let moviesResult):
            upcomingMovies = moviesResult.results ?? []
            view?.reloadCollectionView()
            view?.setupPageController(number: upcomingMovies.count)
        case .failure(let error):
            print(error)
            
        }
    }
}

