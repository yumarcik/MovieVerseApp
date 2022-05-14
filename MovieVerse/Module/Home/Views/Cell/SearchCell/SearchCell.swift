//
//  SearchCell.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import UIKit

protocol SearchCellProtocol: AnyObject {
    func setNameLbl(_ text: String)
}

class SearchCell: UITableViewCell {
    
    @IBOutlet private weak var nameLbl: UILabel!
    
    var cellPresenter: SearchCellPresenterProtocol! {
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

extension SearchCell: SearchCellProtocol {
    
    func setNameLbl(_ text: String) {
        nameLbl.text = text
    }
    
}
