//
//  MoviesListView+CollectionView.swift
//  TheMoviesDB
//
//  Created by Manuel Soberanis on 19/08/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import Foundation
import UIKit

extension MoviesListView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.getRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesListCellID, for: indexPath) as! MoviesListCell
        movieCell.backgroundColor = .clear
        movieCell.configureView(movieResults: presenter.getResults(index: indexPath.row))
        movieCell.setPosterImage(posterImages: presenter.getPosterImage(index: indexPath.row))
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resultRow = presenter.getResults(index: indexPath.row)
//        let resultRow = results[indexPath.row]
        let movieDescriptionView = MovieDescriptionView()
        movieDescriptionView.idMovie = resultRow.id
        movieDescriptionView.movieTitle = resultRow.title
        movieDescriptionView.date = resultRow.release_date
        movieDescriptionView.votesAVG = resultRow.vote_average
        self.navigationController?.pushViewController(movieDescriptionView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let width = screenWidth / numberItems
        let height = width * 1.51098
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    

    
    
}//end
