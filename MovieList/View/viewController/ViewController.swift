//
//  ViewController.swift
//  MovieList
//
//  Created by Azad on 5/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let model = MovieViewModel()
    
    var movieToSearch : String = "Marvel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuareTableView()
        model.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.updateMovies(movieToSearch)
    }


}

extension ViewController: UITableViewDataSource {
    func configuareTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MovieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        
        let movie = model.movieList[indexPath.row]
        
        cell.bindMovie(movie: movie)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: MovieViewModelProtocol {
    func didUpdateMovies() {
        tableView.reloadData()
    }
}

