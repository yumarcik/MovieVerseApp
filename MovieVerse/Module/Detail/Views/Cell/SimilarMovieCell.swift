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

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    
    var cellPresenter: SimilarMovieCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        layer.borderColor = UIColor.blue.cgColor
//        layer.borderWidth = 1
    }
    
}

extension SimilarMovieCell: SimilarMovieCellProtocol {
    
    func setReleaseDateLbl(_ text: String) {
        releaseDateLbl.text = text
    }
    
    func setPosterImg(_ imageUrl: String) {
        let url = URL(string: Constants.posterBaseURL + imageUrl)
        posterImg.kf.setImage(with: url)
    }
    
    func setNameLbl(_ text: String) {
        nameLbl.text = text
    }
    
}
