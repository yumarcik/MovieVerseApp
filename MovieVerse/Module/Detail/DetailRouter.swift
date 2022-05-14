//
//  DetailRouter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import Foundation
import UIKit

protocol DetailRouterProtocol: AnyObject {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case openURL(url: URL)
    case detail(movieId: Int)
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension DetailRouter: DetailRouterProtocol {
    
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .openURL(let url):
            UIApplication.shared.open(url)
        case .detail(let movieId):
            let detailVC = DetailRouter.createModule()
            detailVC.movieId = movieId
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

