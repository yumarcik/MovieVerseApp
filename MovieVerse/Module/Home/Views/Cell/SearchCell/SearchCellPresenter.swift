//
//  SearchCellPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation

protocol SearchCellPresenterProtocol {
    func load()
}

final class SearchCellPresenter {
    
    weak var view: SearchCellProtocol?
    private var searchedMovies: Movies
    
    init(view: SearchCellProtocol, searchedMovies: Movies) {
        self.view = view
        self.searchedMovies = searchedMovies
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    
    func load() {
        view?.setNameLbl(searchedMovies.title ?? "")
    }
    
}
