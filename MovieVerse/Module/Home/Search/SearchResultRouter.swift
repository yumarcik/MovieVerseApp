//
//  SearchResultRouter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 4.05.2022.
//

import Foundation

protocol SearchResultRouterProtocol: AnyObject {
    func navigate(_ route: SearchResultRoutes)
}

enum SearchResultRoutes {
    case detail(movieId: Int)
}

final class SearchResultRouter {
    
    weak var viewController: SearchResultViewController?
    
    static func createModule() -> SearchResultViewController {
        let view = SearchResultViewController()
        let interactor = SearchResultInteractor()
        let router = SearchResultRouter()
        let presenter = SearchResultPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SearchResultRouter: SearchResultRouterProtocol {
    
    func navigate(_ route: SearchResultRoutes) {
        switch route {
        case .detail(let movieId):
            
            let detailVC = DetailRouter.createModule()
            detailVC.movieId = movieId
//            viewController?.navigationController?.pushViewController(detailVC, animated: true)
            viewController?.present(detailVC, animated: true, completion: nil)

        }
    }
    
}

