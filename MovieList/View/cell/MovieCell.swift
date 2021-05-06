//
//  MovieCell.swift
//  MovieList
//
//  Created by Azad on 5/6/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String{
        return String(describing: self)
    }

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindMovie(movie: Movie){
        //Change the url
        
        let images = UserDefaultsHandler.loadCodable(key: .imageBaseUrl, value: ImagesModel.self)
        guard let baseUrl = images?.images.baseURL else {return}
        
        guard let backDropPath = movie.backdropPath else {return}
        //backDropPath.remove(at: backDropPath.startIndex)
        
        print("back-->\(backDropPath)")
        
        //guard let size = images?.images.posterSizes[0] else {return}
        
        guard let url = URL(string: "\(baseUrl)w500\(backDropPath)") else { return }
        
        print("imageUrl -->\(url)")

        imgView.load(urlString: "\(baseUrl)w500\(backDropPath)")
        
        self.titleLbl.text = movie.title
        self.descriptionLbl.text = movie.overview
        
    }
    
}

extension UIImageView {
    func loadImge(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}


extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
