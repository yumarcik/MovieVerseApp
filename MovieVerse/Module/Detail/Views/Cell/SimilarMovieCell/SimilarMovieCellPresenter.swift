//
//  SimilarMovieCellPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import Foundation

protocol SimilarMovieCellPresenterProtocol {
    func load()
}

final class SimilarMovieCellPresenter {
    
    weak var view: SimilarMovieCellProtocol?
    private var similarMovie: SimilarMovie
    
    init(view: SimilarMovieCellProtocol?, similarMovie: SimilarMovie) {
        self.view = view
        self.similarMovie = similarMovie
    }
}

extension SimilarMovieCellPresenter: SimilarMovieCellPresenterProtocol {
    
    func load() {
        view?.setNameLbl(similarMovie.title ?? "")
        view?.setPosterImg(similarMovie.posterPath ?? "")
        view?.setReleaseDateLbl(similarMovie.releaseDate ?? "")
    }

}
