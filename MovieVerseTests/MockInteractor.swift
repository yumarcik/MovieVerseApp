//
//  MockInteractor.swift
//  MovieVerseTests
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation
@testable import MovieVerse

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var invokedGetNowPlayingMovie = false
    var invokedGetNowPlayingMovieCount = 0
    
    var invokedGetUpcomingMovie = false
    var invokedGetUpcomingMovieCount = 0
    
    func getNowPlayingMovies() {
        self.invokedGetNowPlayingMovie = true
        self.invokedGetNowPlayingMovieCount += 1
    }
    
    func getUpcomingMovies() {
        self.invokedGetUpcomingMovie = true
        self.invokedGetUpcomingMovieCount += 1
    }
    
    
}
