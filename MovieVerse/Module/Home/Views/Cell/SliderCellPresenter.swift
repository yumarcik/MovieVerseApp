//
//  SliderCellPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import Foundation

protocol SliderCellPresenterProtocol {
    func load()
}

final class SliderCellPresenter {
    
    weak var view: SliderCellProtocol?
    private var movies: Movies
    
    init(view: SliderCellProtocol, movies: Movies) {
        self.view = view
        self.movies = movies
    }
}

extension SliderCellPresenter: SliderCellPresenterProtocol {
    
    func load() {
        view?.setMovieImg(movies.posterPath ?? "")
        view?.setNameLbl(movies.title ?? "")
    }
    
    
}
