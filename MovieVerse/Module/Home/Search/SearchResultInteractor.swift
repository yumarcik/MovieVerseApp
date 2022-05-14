//
//  SearchResultInteractor.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

protocol SearchResultInteractorProtocol: AnyObject {
    func getSearchResult(searchedText: String)
}

protocol SearchResultInteractorOutputProtocol: AnyObject {
    func getSearchResultSuccess(result: MoviesResult)
}

final class SearchResultInteractor {
    var output: SearchResultInteractorOutputProtocol?
}

extension SearchResultInteractor: SearchResultInteractorProtocol {
    func getSearchResult(searchedText: String) {
        moviesService.getSearchedMovies(searchedText: searchedText) { [weak self] result in
            guard let self = self else { return }
            self.output?.getSearchResultSuccess(result: result)
        }
    }
}
