//
//  ServiceManager.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import Foundation

protocol MoviesServiceProtocol {
    
    func getNowPlayingMovies(page: Int, completionHandler: @escaping (MoviesResult) -> ())
    func getUpcomingMovies(page: Int, completionHandler: @escaping (MoviesResult) -> ())
    func getDetails(movieId: Int, completionHandler: @escaping(MovieDetailsResult) -> ())
    func getSimilarMovies(movieId: Int, completionHandler: @escaping(SimilarMoviesResult) -> ())
}

struct MoviesService: MoviesServiceProtocol {
    // HomePage
    
    func getNowPlayingMovies(page: Int, completionHandler: @escaping (MoviesResult) -> ()) {
        NetworkManager.shared.request(Router.nowPlayingMovies(page: page), decodeToType: MovieData.self, completionHandler: completionHandler)
    }
    
    func getUpcomingMovies(page: Int, completionHandler: @escaping (MoviesResult) -> ()) {
        NetworkManager.shared.request(Router.upcomingMovies(page: page), decodeToType: MovieData.self, completionHandler: completionHandler)
    }
    
    // Details

    func getSimilarMovies(movieId: Int, completionHandler: @escaping (SimilarMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.getSimilarMovies(movieId: movieId), decodeToType: SimilarMovieData.self, completionHandler: completionHandler)
    }
    
    func getDetails(movieId: Int, completionHandler: @escaping (MovieDetailsResult) -> ()) {
        NetworkManager.shared.request(Router.details(movieId: movieId), decodeToType: Details.self, completionHandler: completionHandler)
    }
    
}
