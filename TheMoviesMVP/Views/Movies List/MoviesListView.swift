//
//  MoviesListView.swift
//  TheMoviesDB
//
//  Created by Manuel Soberanis on 19/08/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import UIKit

class MoviesListView: UIViewController{
    
    //MARK:- Components
    
    let collectionView : UICollectionView = {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/2, height: ((screenWidth/2) * 1.51098))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let moviesListCellID = "MoviesListCellID"
    var numberItems: CGFloat = 2
    
    var presenter : MovieListPresenter!
    
    //MARK:- Load and Layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieListPresenter(view: self)
        presenter.bind()
        configureView()
        self.setupCollectionView()
    }
    
    deinit {
        presenter.unbind()
    }
    
    func configureView() {
        self.view.backgroundColor = .white
        self.title = "The Movies DB"
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesListCell.self, forCellWithReuseIdentifier: moviesListCellID)
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK:- Functions
    //Moved to MovieListPresenter
    
    
}//end code

extension MoviesListView: MovieListDelegate{
    func displayMovies() {
        self.collectionView.reloadData()
    }
}
