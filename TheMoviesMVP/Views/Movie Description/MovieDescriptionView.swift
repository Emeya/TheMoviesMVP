//
//  MovieDescriptionView.swift
//  TheMoviesDB
//
//  Created by Manuel Soberanis on 20/08/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import UIKit

class MovieDescriptionView: UIViewController {

    //MARK: - Components
    let tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        return tv
    }()
    
    var idMovie : Int?
    var movieTitle : String?
    var votesAVG : Float?
    var date : String?
    
    var presenter : MovieDescriptionPresenter!
    
    let movieDescCellID = "movieDescCellID"
    
    
    //MARK:- Load and Layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieDescriptionPresenter(view: self)
        presenter.bind()
        presenter.getMovieDetails(idMovie: idMovie!)
        configureView()
    }
    
    deinit {
        presenter.unbind()
    }
    
    func configureView() {
        view.backgroundColor = .white
        self.setupTableView()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieDescCell.self, forCellReuseIdentifier: movieDescCellID)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Functions
    //moved to MovieDescriptionPresenter
    
}//end code

extension MovieDescriptionView : MovieDescDelegate{
    
    func displayMovies() {
        self.tableView.reloadData()
    }

}
