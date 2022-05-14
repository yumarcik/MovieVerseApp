//
//  SimilarMovieCell.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import UIKit

protocol SimilarMovieCellProtocol: AnyObject {
    
    func setNameLbl(_ text: String)
    func setReleaseDateLbl(_ text: String)
    func setPosterImg(_ imageUrl: String)
}

class SimilarMovieCell: UICollectionViewCell {

    @IBOutlet private weak var posterImg: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var releaseDateLbl: UILabel!
    
    var cellPresenter: SimilarMovieCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension SimilarMovieCell: SimilarMovieCellProtocol {
    
    func setReleaseDateLbl(_ text: String) {
        releaseDateLbl.text = text
    }
    
    func setPosterImg(_ imageUrl: String) {
        posterImg.layer.cornerRadius = 15
        posterImg.clipsToBounds = true
        let url = URL(string: Constants.posterBaseURL + imageUrl)
        posterImg.kf.setImage(with: url)
    }
    
    func setNameLbl(_ text: String) {
        nameLbl.text = text
    }
    
}
