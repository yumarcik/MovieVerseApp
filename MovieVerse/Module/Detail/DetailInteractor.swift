//
//  DetailInteractor.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import Foundation

typealias MovieDetailsResult = Result<Details, Error>
typealias SimilarMoviesResult = Result<SimilarMovieData, Error>

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

protocol DetailInteractorProtocol: AnyObject {
    func getMovieDetail(movieId: Int)
    func getSimilarMovies(movieId: Int)
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func getMovieDetailSuccess(result: MovieDetailsResult)
    func getSimilarMoviesSuccess(result: SimilarMoviesResult)
}

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func getSimilarMovies(movieId: Int) {
        moviesService.getSimilarMovies(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.getSimilarMoviesSuccess(result: result)
        }
    }
    
    func getMovieDetail(movieId: Int) {
        moviesService.getDetails(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.getMovieDetailSuccess(result: result)
        }
    }
    
}
