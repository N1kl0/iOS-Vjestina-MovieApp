//
//  MovieListSectionCell.swift
//  movieApp
//
//  Created by <3 on 18.05.2024..
//

import UIKit
import PureLayout
import MovieAppData

class MovieListSectionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private var movieUseCase: MovieUseCaseProtocol?
    private var section: Int = 0
    private weak var delegate: MovieNavigationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        contentView.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    func configure(with section: Int, movieUseCase: MovieUseCaseProtocol, delegate: MovieNavigationDelegate) {
           self.section = section
           self.movieUseCase = movieUseCase
           self.delegate = delegate
           collectionView.tag = section
           collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movieUseCase = movieUseCase else { return 0 }
        switch collectionView.tag {
        case 0:
            return movieUseCase.popularMovies.count // Number of popular movies
        case 1:
            return movieUseCase.freeToWatchMovies.count // Number of free to watch movies
        case 2:
            return movieUseCase.trendingMovies.count // Number of trending movies
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        guard let movieUseCase = movieUseCase else { return cell }
        let movie: MovieModel
        
        switch collectionView.tag {
        case 0:
            movie = movieUseCase.popularMovies[indexPath.item]
        case 1:
            movie = movieUseCase.freeToWatchMovies[indexPath.item]
        case 2:
            movie = movieUseCase.trendingMovies[indexPath.item]
        default:
            return cell
        }
        cell.configure(with: movie, delegate: delegate!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieUseCase = movieUseCase else { return }
        let movie: MovieModel
        
        switch collectionView.tag {
        case 0:
            movie = movieUseCase.popularMovies[indexPath.item]
        case 1:
            movie = movieUseCase.freeToWatchMovies[indexPath.item]
        case 2:
            movie = movieUseCase.trendingMovies[indexPath.item]
        default:
            return
        }
        delegate?.navigateToMovieDetails(with: movie.id)
    }
}



