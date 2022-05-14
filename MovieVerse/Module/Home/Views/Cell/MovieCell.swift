//
//  TableViewCell.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 2.05.2022.
//

import UIKit

protocol MovieCellProtocol: AnyObject {
    func setNameLbl(_ text: String)
    func setDetailLbl(_ text: String)
    func setMovieImg(_ imageUrl: String)
}

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    var cellPresenter: MovieCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MovieCell: MovieCellProtocol {
    
    func setNameLbl(_ text: String) {
        nameLbl.text = text
    }
    
    func setDetailLbl(_ text: String) {
        detailLbl.text = text
    }
    
    func setMovieImg(_ imageUrl: String) {
        let url = URL(string: Constants.posterBaseURL + imageUrl)
        movieImg.kf.setImage(with: url)
    }
    
}
