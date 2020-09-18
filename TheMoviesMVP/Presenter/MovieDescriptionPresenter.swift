//
//  MovieDescriptionPresenter.swift
//  TheMoviesMVP
//
//  Created by Manuel Soberanis on 18/09/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import UIKit
import Alamofire

protocol MovieDescDelegate : NSObjectProtocol {
    
    func configureView()
    
    func displayMovies()
    
//    func getMovieDetails(idMovie: Int?)
    
}

class MovieDescriptionPresenter {
    
    private weak var view: MovieDescDelegate!
    
    private var movieDetail = MovieDetail()
//    private var genreArray = [String]()
    private var genreArray = [String]()
    private var posterImages = UIImage()
    let posterUrl = "https://image.tmdb.org/t/p/w342"
    
    init(view: MovieDescDelegate) {
        self.view = view
    }
    
    func bind(){
        self.view.configureView()
    }
    
    func unbind() {
        self.view = nil
    }

    
    func getMovieDetails(idMovie: Int?){
        guard let idMovie = idMovie else {return}
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=634b49e294bd1ff87914e7b9d014daed&language=es-ES") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let DataResponse = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    self.movieDetail = try decoder.decode(MovieDetail.self, from: DataResponse)
                    for tag in self.movieDetail.genres! {
                        self.genreArray.append(tag.name!)
                    }
                    self.getMoviePoster()
                } catch {
                    print("OOPS , An Error Occured: \(error)")
                }
            case.failure(let error):
                print(error)
            }
        }
        
    }//details
    
    func getMoviePoster(){
        guard let imgUrl = self.movieDetail.backdrop_path else {return}
        guard let url = URL(string: posterUrl + imgUrl ) else { return }
        do {
            let imgData = try Data(contentsOf: url)
            posterImages = UIImage(data: imgData)!
            DispatchQueue.main.async {
                self.view.displayMovies()
            }
        }catch{
//            self.showConnectionErrorAlert()
            return
        }
        
    }//get posters
    
    func getMovieDetail()-> MovieDetail{
        return movieDetail
    }
    
    func getGenre()-> [String]{
        return genreArray
    }
    
    func getPosterImage()-> UIImage{
        return posterImages
    }
    
    
    
    
}
