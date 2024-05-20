//
//  movieSeriesListViewController.swift
//  movieApp
//
//  Created by <3 on 18.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class AllMoviesViewController: UIViewController, MovieNavigationDelegate {


    private var collectionView: UICollectionView!
    private let movieUseCase: MovieUseCaseProtocol = MovieUseCase()
    

    private var moviesWithYears: [(movie: MovieModel, year: Int)] = []
       

    override func viewDidLoad() {
        super.viewDidLoad()
        populateMoviesWithYears()
        setupAllMovies()
    }
    
    
    private func setupAllMovies(){
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 170) // Adjusted size for the custom cell
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AllMoviesSectionCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.reloadData()
            
    }
    
    
    private func populateMoviesWithYears() {
        for movie in movieUseCase.allMovies {
            let movieData = MovieData(movieID: movie.id)
            if let year = movieData.year {
                moviesWithYears.append((movie, year))
            }
        }
    }
    
    
    func navigateToMovieDetails(with movieID: Int) {
        let movieDetailsViewController = MovieDetailsViewController(movieID: movieID)
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}


extension AllMoviesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieUseCase.allMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! AllMoviesSectionCell
        let movieWithYear = moviesWithYears[indexPath.item]
        cell.configure(with: movieWithYear.movie, year: movieWithYear.year, delegate: self) 
        return cell
    }
}

extension AllMoviesViewController: UICollectionViewDelegateFlowLayout {}













//extension movieSeriesViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1 // Single section for all movies in the series
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return moviesWithYears.count  // Return filtered number of movies
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! AllMoviesSectionCell
//        let movieWithYear = moviesWithYears[indexPath.item]
//        cell.configure(with: movieWithYear.movie, year: movieWithYear.year) // CHANGE: Pass movie and year
//        return cell
//    }
//}
//
//extension movieSeriesViewController: UICollectionViewDelegateFlowLayout {
//    // Customize layout if needed
//}
