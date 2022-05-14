//
//  DetailPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func numberOfItems() -> Int
    func getSimilarMovie(_ index: Int) -> SimilarMovie?
    func didSelectItemAt(row: Int)
}

//extension DetailPresenter {
//    fileprivate enum Constants {
//        static let firstPage: Int = 1
//    }
//}

final class DetailPresenter: DetailPresenterProtocol {
    
    func didSelectItemAt(row: Int) {
        router.navigate(.detail(movieId: similarMovies[row].id!))
    }
    
    func numberOfItems() -> Int {
        return similarMovies.count
        
    }
    
    func getSimilarMovie(_ index: Int) -> SimilarMovie? {
        return similarMovies[safe: index]
    }

    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    private var similarMovies: [SimilarMovie] = []
    
    init(view: DetailViewControllerProtocol, router: DetailRouterProtocol, interactor: DetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setCollectionView()
        if let movieId = view?.getMovieId() {
            interactor.getMovieDetail(movieId: movieId)
            interactor.getSimilarMovies(movieId: movieId)
        }
        
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func getSimilarMoviesSuccess(result: SimilarMoviesResult) {
        
        switch result {
            
        case .success(let similarMoviesResult):
            similarMovies = similarMoviesResult.results ?? []
            view?.reloadCollectionView()
        case .failure(let error):
            print(error)
            
        }
    }
    
    
    func getMovieDetailSuccess(result: MovieDetailsResult) {
        
        switch result {
            
        case .success(let detailResult):
            view?.setMovieDetail(image: Constants.posterBaseURL + (detailResult.posterPath ?? ""), title: detailResult.title ?? "", body: detailResult.overview ?? "", link: detailResult.homepage ?? "", releaseDate: detailResult.releaseDate ?? "", rating: String(detailResult.voteAverage ?? 0))
            
        case .failure(let error):
            print(error)
            
        }
    }
    
}
