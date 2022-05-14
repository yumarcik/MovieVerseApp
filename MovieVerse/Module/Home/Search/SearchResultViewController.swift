//
//  SearchResultViewController.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import UIKit

protocol SearchResultViewControllerProtocol: AnyObject {
    
    func setupTableView()
    func reloadTableView()
    func didUpdateText(text: String)
}

class SearchResultViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: SearchResultPresenterProtocol!
    var homeView: HomeViewControllerProtocol?
    let _rowHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white:1, alpha: 0.5)
        presenter.viewDidLoad()
    
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: getTableHeight() + _rowHeight)
    }
    
    private func getTableHeight() -> CGFloat {
        if presenter.numberOfItems() >= 8 {
            return 8 * _rowHeight + 95
        } else {
            return CGFloat(presenter.numberOfItems()) * _rowHeight + 95
        }
    }
    
 }

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        if let movie = presenter.getSearchResultMovie(index: indexPath.row) {
            cell.cellPresenter = SearchCellPresenter(view: cell, searchedMovies: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = presenter.getSearchResultMovie(index: indexPath.row)?.id {
            homeView?.moveToDetail(movieId: id)
        }
        
    }
    
}

extension SearchResultViewController: SearchResultViewControllerProtocol {
    
    func didUpdateText(text: String) {
        presenter.getSearchResults(text)
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    }
    
    func reloadTableView() {
        tableView.reloadData()
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: getTableHeight())
        view.layoutIfNeeded()
    }
    
    
}

