//
//  HomeInteractor.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 30.04.2022.
//

import Foundation

typealias MoviesResult = Result<MovieData, Error>

fileprivate var moviesService: MoviesServiceProtocol = MoviesService()

protocol HomeInteractorProtocol: AnyObject {
    func getNowPlayingMovies()
    func getUpcomingMovies()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func getNowPlayingMoviesSuccess(result: MoviesResult)
    func getUpcomingMoviesSuccess(result: MoviesResult)
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func getNowPlayingMovies() {
        moviesService.getNowPlayingMovies(page: 1) { [weak self] result in
            guard let self = self else { return }
            self.output?.getNowPlayingMoviesSuccess(result: result)
        }
    }
    
    func getUpcomingMovies() {
        moviesService.getUpcomingMovies(page: 1) { [weak self] result in
            guard let self = self else { return }
            self.output?.getUpcomingMoviesSuccess(result: result)
        }
    }
    
    
}
