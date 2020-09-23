//
//  MovieListPresenter.swift
//  TheMoviesMVP
//
//  Created by Manuel Soberanis on 18/09/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import UIKit
import Alamofire

protocol MovieListDelegate: NSObjectProtocol {
    
    func configureView()
    
    func displayMovies()
    
}

class MovieListPresenter {
                            
    private weak var view: MovieListDelegate!
    private var movieResult : [MovieResult] = []
    private var posterImages = [UIImage]()
    
    var fetchingDataAlert : UIAlertController?
    
    init(view: MovieListDelegate) {
        self.view = view
    }
    
    func bind(){
        self.view.configureView()
        self.fetchMoviesData()
    }
    
    func unbind() {
        self.view = nil
    }
    
    //MARK: Nueva funcion
    func fetchMoviesData(){
        Movie.fetchMovies { (result) in
            switch result {
            case .success(let movies):
                self.movieResult = movies.results!
                self.getMoviePoster()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Funcion antigua.
    /*
    func getMoviesData(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=634b49e294bd1ff87914e7b9d014daed&language=es-ES&page=1") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let DataResponse = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(Movie.self, from: DataResponse)
                    self.movieResult = data.results!
                    self.getMoviePoster()
                } catch {
                    print("OOPS , An Error Occured: \(error)")
                }
            case.failure(let error):
                print(error)
            }
        }
    }//movies
 */
    
    //MARK: Trae el poster de la pelicula (es la manera correcta de hacer esto?)
    func getMoviePoster(){
        posterImages.removeAll()
        for item in movieResult {
            guard let url = URL(string: K.EndPoints.MovieServer.moviePosterPath + item.poster_path!  ) else { return }
            do {
                let imgData = try Data(contentsOf: url)
                posterImages.append(UIImage(data: imgData)!)
            }catch{
                //                self.showConnectionErrorAlert()
                return
            }
        }
        DispatchQueue.main.async {
            self.view.displayMovies()
        }
        
    }//get posters
    
    
    func getRows()->Int{
        return self.movieResult.count
    }
    
    func getResults(index: Int)-> MovieResult{
        return self.movieResult[index]
    }
    
    func getPosterImage(index: Int)-> UIImage{
        return self.posterImages[index]
    }
    
}//end
