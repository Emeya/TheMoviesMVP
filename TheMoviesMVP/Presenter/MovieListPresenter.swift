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
    private var results : [Results] = []
    private var posterImages = [UIImage]()
    let posterUrl = "https://image.tmdb.org/t/p/w342"
    
    var fetchingDataAlert : UIAlertController?
    
    init(view: MovieListDelegate) {
        self.view = view
    }
    
    func bind(){
        self.view.configureView()
        self.getMoviesData()
    }
    
    func unbind() {
        self.view = nil
    }
    
    //MARK: Takes a few second to load the data, please be patient.
    func getMoviesData(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=634b49e294bd1ff87914e7b9d014daed&language=es-ES&page=1") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let DataResponse = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(MoviesJson.self, from: DataResponse)
                    self.results = data.results!
                    self.getMoviePoster()
                } catch {
                    print("OOPS , An Error Occured: \(error)")
                }
            case.failure(let error):
                print(error)
            }
        }
    }//movies
    
    func getMoviePoster(){
        posterImages.removeAll()
        for item in results {
            guard let url = URL(string: posterUrl + item.poster_path!  ) else { return }
            do {
                let imgData = try Data(contentsOf: url)
                posterImages.append(UIImage(data: imgData)!)
            }catch{
                //                self.showConnectionErrorAlert()
                return
            }
        }
        DispatchQueue.main.async {
//            self.fetchingDataAlert?.dismiss(animated: true, completion: {
                //                self.collectionView.reloadData()
            self.view.displayMovies()
//            })
        }
        
    }//get posters
    
    
    func getRows()->Int{
        return self.results.count
    }
    
    func getResults(index: Int)-> Results{
        return self.results[index]
    }
    
    func getPosterImage(index: Int)-> UIImage{
        return self.posterImages[index]
    }
    
    
    
//    func showConnectionErrorAlert(){
//        DispatchQueue.main.async {
//            self.fetchingDataAlert?.dismiss(animated: true, completion: {
//                let alert = UIAlertController(title: "Error", message: "Revisa tu conexion a internet", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Reintentar Conexion?", style: .default, handler: { (_) in
////                    self.getMoviesData()
//                }))
//
//                alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (_) in
//                    alert.dismiss(animated: true)
//                }))
//                self.fetchingDataAlert!.present(alert, animated: true)
//            })
//        }
//    }
//

}//end
