//
//  SearchResultPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation

protocol SearchResultPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func getSearchResults(_ text: String)
    func getSearchResultMovie(index: Int) -> Movies?
}

final class SearchResultPresenter: SearchResultPresenterProtocol {
    
    func getSearchResultMovie(index: Int) -> Movies? {
        return searchResultMovies[safe: index]
    }
        
    
    private var searchResultMovies: [Movies] = []
    let router: SearchResultRouterProtocol!
    unowned var view: SearchResultViewControllerProtocol?
    let interactor: SearchResultInteractorProtocol!
    
    init(view: SearchResultViewControllerProtocol, interactor: SearchResultInteractorProtocol, router: SearchResultRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupTableView()
    }
    
    func numberOfItems() -> Int {
        return searchResultMovies.count
    }
    
    func getSearchResults(_ text: String) {
        
        if text.count > 2 {
            interactor.getSearchResult(searchedText: text)
        } else {
            searchResultMovies = []
            view?.reloadTableView()
        }
    }
    
}

extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    
    func getSearchResultSuccess(result: MoviesResult) {
        
        switch result {
            
        case .success(let searchResult):
            searchResultMovies = searchResult.results ?? []
            view?.reloadTableView()
        case .failure(let error):
            print(error)
            
        }
    }
    
    
}

