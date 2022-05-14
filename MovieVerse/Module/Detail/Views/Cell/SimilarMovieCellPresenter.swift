//
//  SimilarMovieCellPresenter.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import Foundation

protocol SimilarMovieCellPresenterProtocol {
    func load()
    func cellTapped()
}

//protocol DetailCellDelegate: AnyObject {
//    func addReadingListButtonTapped(url: String)
//}

final class SimilarMovieCellPresenter {
    
    weak var view: SimilarMovieCellProtocol?
    private var similarMovie: SimilarMovie
    //weak var delegate: DetailCellDelegate?
    
    init(view: SimilarMovieCellProtocol?, similarMovie: SimilarMovie /*, delegate: DetailCellDelegate*/) {
        self.view = view
        self.similarMovie = similarMovie
        //self.delegate = delegate
    }
    
//    private func isAddedReadingList() -> Bool {
//        article.readingListStatus ? true : false
//    }
}

extension SimilarMovieCellPresenter: SimilarMovieCellPresenterProtocol {
    
    func load() {
        print("************")
        print(similarMovie)
        view?.setNameLbl(similarMovie.title ?? "")
        view?.setPosterImg(similarMovie.posterPath ?? "")
        view?.setReleaseDateLbl(similarMovie.releaseDate ?? "")

//        view?.setTitleLabel(article.title ?? "")
//        view?.setDescriptionLabel(article.description ?? "")
//        view?.setNewsImageView(article.urlToImage ?? "")
//        let buttonText = article.readingListStatus ? Constans.removeReadingList : Constans.addReadingList
//        view?.setReadingListButtonTitle(buttonText, isAdded: isAddedReadingList())
    }
    
    func cellTapped() {
//        article.readingListStatus.toggle()
//        if let url = article.url {
//            delegate?.addReadingListButtonTapped(url: url)
//            let buttonText = article.readingListStatus ? Constans.removeReadingList : Constans.addReadingList
//            view?.setReadingListButtonTitle(buttonText, isAdded: !isAddedReadingList())
//        }
    }
    
    
}
