//
//  SliderCell.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import UIKit

protocol SliderCellProtocol: AnyObject {
    func setNameLbl(_ text: String)
    func setMovieImg(_ imageUrl: String)
}

class SliderCell: UICollectionViewCell {
    
    @IBOutlet private weak var sliderImg: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    
    var cellPresenter: SliderCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SliderCell: SliderCellProtocol {
    
    func setNameLbl(_ text: String) {
        nameLbl.text = text
    }
    
    func setMovieImg(_ imageUrl: String) {
        let url = URL(string: Constants.posterBaseURL + imageUrl)
        sliderImg.kf.setImage(with: url)
    }
    
    
}
