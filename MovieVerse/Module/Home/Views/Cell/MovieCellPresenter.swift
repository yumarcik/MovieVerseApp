//
//  MovieCellPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import Foundation

protocol MovieCellPresenterProtocol {
    func load()
}

final class MovieCellPresenter {
    
    weak var view: MovieCellProtocol?
    private var movies: Movies
    
    init(view: MovieCellProtocol, movies: Movies) {
        self.view = view
        self.movies = movies
    }
}

extension MovieCellPresenter: MovieCellPresenterProtocol {
    
    func load() {
        view?.setNameLbl(movies.title ?? "")
        view?.setDetailLbl(movies.overview ?? "")
        view?.setMovieImg(movies.posterPath ?? "")
    }
    
    
}
