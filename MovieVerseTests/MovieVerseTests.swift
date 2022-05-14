//
//  MovieVerseTests.swift
//  MovieVerseTests
//
//  Created by Yağmur Polat on 27.04.2022.
//

import XCTest
@testable import MovieVerse

class MovieVerseTests: XCTestCase {

    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
    }

    func test_viewWillAppear_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.didReloadCollectionView, "It's TRUE, it should be FALSE")
        XCTAssertFalse(view.didReloadTableView, "It's TRUE, it should be FALSE")
        XCTAssertFalse(view.didSetupCollectionView, "It's TRUE, it should be FALSE")
        XCTAssertFalse(view.didSetupTableView, "It's TRUE, it should be FALSE")
        presenter.viewDidLoad()
        XCTAssertTrue(view.didReloadTableView, "It's FALSE, it should be TRUE")
        XCTAssertTrue(view.didReloadCollectionView, "It's FALSE, it should be TRUE")
        XCTAssertTrue(view.didSetupTableView, "It's FALSE, it should be TRUE")
        XCTAssertTrue(view.didSetupCollectionView, "It's FALSE, it should be TRUE")
    }
    
    func test_getMovie() {
        XCTAssertNil(presenter.getUpcomingMovie(1)?.title, "Movie name is not empty")
        XCTAssertNil(presenter.getNowPlayingMovie(1)?.title, "Movie name is not empty")
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
        XCTAssertEqual(presenter.getUpcomingMovie(0)?.title, "Uncharted")
        XCTAssertEqual(presenter.numberOfItems(), 0)
    }
}

extension MoviesResult {
    static var response: MovieData {
        let bundle = Bundle(for: MovieVerseTests.self)
        let path = bundle.path(forResource: "Movie", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieData.self, from: data)
        return movieResponse
    }
}
