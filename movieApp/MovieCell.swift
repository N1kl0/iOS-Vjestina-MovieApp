////
////  MovieCell.swift
////  movieApp
////
////  Created by <3 on 18.05.2024..
////
//


import UIKit
import MovieAppData


class MovieCell: UICollectionViewCell {
    
    private let imageView: UIImageView
    private var dataTask: URLSessionDataTask?
    private weak var delegate: MovieNavigationDelegate?
    private var movie: MovieModel?
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: .zero)
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        let button = UIButton(type: .system)
        let icon = UIImage(systemName: "heart")
        
        button.setImage(icon, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.alpha = 0.7
        button.layer.cornerRadius = 15
        
        imageView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 7),
            button.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 7),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        backgroundColor = .blue
        layer.cornerRadius = 20
        contentView.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(with movie: MovieModel, delegate: MovieNavigationDelegate) {
        self.movie = movie
        self.delegate = delegate
        guard let url = URL(string: movie.imageUrl) else { return }
        
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        dataTask?.resume()
    }
    
    @objc private func didTapCell() {
        if let movie = movie {
            delegate?.navigateToMovieDetails(with: movie.id) 
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        dataTask?.cancel()
        dataTask = nil
    }
}


















//import Foundation
//import UIKit
//import PureLayout
//import MovieAppData
//
//
//
//
//class MovieCell: UICollectionViewCell {
//    
//    private let imageView: UIImageView
//    private var dataTask: URLSessionDataTask?
//
//    override init(frame: CGRect) {
//        imageView = UIImageView(frame: .zero)
//        super.init(frame: frame)
//        setupCell()
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupCell() {
//        
//        let button = UIButton(type: .system)
//        let icon = UIImage(systemName: "heart")
//        
//        button.setImage(icon, for: .normal)
//        
//        
//        button.tintColor = .white
//        button.backgroundColor = .black
//        button.alpha = 0.7
//        button.layer.cornerRadius = 15
//        
//      
//       
//
//        // Set button constraints
//        //button.autoPinEdge(.top, to: .top, of: imageView, withOffset: 10)
//        
//        imageView.addSubview(button)
//        
//        button.translatesAutoresizingMaskIntoConstraints = false
//        // Add constraints to position the button slightly down and to the right
//        NSLayoutConstraint.activate([
//            button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 7), // Move down by 50 points
//            button.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 7), // Move right by 50 points
//            button.widthAnchor.constraint(equalToConstant: 30), // Set width
//            button.heightAnchor.constraint(equalToConstant: 30) // Set height
//        ])
//        
//        
//        
//        
//        backgroundColor = .blue // Set the background color to blue
//        layer.cornerRadius = 20
//        contentView.addSubview(imageView)
//        imageView.autoPinEdgesToSuperviewEdges()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
//        
//        
//        
//    }
//    
//    
//    func configure(with movie: MovieModel) {
//        guard let url = URL(string: movie.imageUrl) else { return }
//        
//        // Cancel any previous image loading task
//        dataTask?.cancel()
//        
//        // Download image asynchronously
//        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self, let data = data, error == nil else { return }
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                self.imageView.image = image
//            }
//        }
//        dataTask?.resume()
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = nil
//        dataTask?.cancel()
//        dataTask = nil
//    }
//}
