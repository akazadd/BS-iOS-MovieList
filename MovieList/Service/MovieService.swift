//
//  MovieService.swift
//  MovieList
//
//  Created by Azad on 5/6/21.
//

import Foundation

struct MovieService {
    private let base_url = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=" 
    
    func fetchMovies(with string: String, completion: @escaping (Movies?, Error?) -> ()) {
        let urlString = "\(base_url)\(string)" //https://www.omdbapi.com/?apikey=X&s=Breaking
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            
            if let data = data,
               let movies = try? JSONDecoder().decode(Movies.self, from: data) {
                completion(movies, nil)
            }
        }
        task.resume()
    }
    
    func fetchImages(completion: @escaping (ImagesModel?, Error?) -> ()){
        let urlString = "https://api.themoviedb.org/3/configuration?api_key=38e61227f85671163c275f9bd95a8803" //https://www.omdbapi.com/?apikey=X&s=Breaking
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            
            if let data = data,
               let movies = try? JSONDecoder().decode(ImagesModel.self, from: data) {
                completion(movies, nil)
            }
        }
        task.resume()
    }
    
}

