//
//  MockRouter.swift
//  MovieVerseTests
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation
@testable import MovieVerse

final class MockHomeRouter: HomeRouterProtocol {
    
    var didNavigate = false
    
    func navigate(_ route: HomeRoutes) {
        self.didNavigate = true
    }
    
    
}
