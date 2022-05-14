//
//  SearchResultViewController.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let _rowHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white:1, alpha: 0.5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")

    }
    
    override func viewDidLayoutSubviews() {
        print("---------------")
        print(tableView.rowHeight)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: _rowHeight * 8 + 95)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
//    }
 }

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        return cell
    }
    
    
}
