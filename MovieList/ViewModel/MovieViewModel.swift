//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Azad on 5/6/21.
//

import UIKit

protocol MovieViewModelProtocol {
    func didUpdateMovies()
}

class MovieViewModel: NSObject {
    var delegate: MovieViewModelProtocol?
    
    fileprivate(set) var movieList: [Movie] = []
    fileprivate(set) var images : Images?{
        didSet{
            
        }
    }
    
    private var movieService = MovieService()

    func updateMovies(_ movieToSearch: String) {
        //let movieToSearch = "Breaking"
        movieService.fetchMovies(with: movieToSearch, completion: { (movieSearchResult, error) in
            if let error = error {
                print(error)
            } else {
                if let movieSearchResult = movieSearchResult {
                    DispatchQueue.main.async{
                        self.movieList = movieSearchResult.results
                        self.delegate?.didUpdateMovies()
                    }
                    
                }
            }
        })
    }
    
    func updateImages() {
        //let movieToSearch = "Breaking"
        movieService.fetchImages( completion: { (images, error) in
            if let error = error {
                print(error)
            } else {
                if let images = images {
                    self.images = images.images
                    UserDefaultsHandler.save(key: .imageBaseUrl, value: images)
                }
            }
        })
    }
    
}
