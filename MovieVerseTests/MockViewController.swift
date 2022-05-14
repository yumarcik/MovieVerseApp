//
//  MockViewController.swift
//  MovieVerseTests
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation
@testable import MovieVerse

final class MockHomeViewController: HomeViewControllerProtocol {
    

    
    var didSetupTableView = false
    var didSetupCollectionView = false
    var didReloadTableView = false
    var didReloadCollectionView = false
    var didGetMovieId: Int = 0
    
    func getMovieId() -> Int? {
        return self.didGetMovieId
    }
    
    func setupTableView() {
        self.didSetupTableView = true
    }
    
    func setupCollectionView() {
        self.didSetupCollectionView = true
    }
    
    func reloadTableView() {
        self.didReloadTableView = true
    }
    
    func reloadCollectionView() {
        self.didReloadCollectionView = true
    }
    
    func moveToDetail(movieId: Int) {
        
    }
}
