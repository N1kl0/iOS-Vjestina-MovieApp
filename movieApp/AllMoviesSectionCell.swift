////
////  AllMoviesSectionCell.swift
////  movieApp
////
////  Created by <3 on 18.05.2024..
////
//





import UIKit
import MovieAppData

class AllMoviesSectionCell: UICollectionViewCell {
    
    
    
    private let imageView: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.layer.cornerRadius = 10
            iv.clipsToBounds = true
            return iv
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.numberOfLines = 0//1
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.numberOfLines = 0
            return label
        }()
    
    
    private var dataTask: URLSessionDataTask?
    private weak var delegate: MovieNavigationDelegate?
    private var movie: MovieModel?
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setupCell()
    }
      
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupCell() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowRadius = 10
        contentView.clipsToBounds = false
                
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
                
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 150),
                    
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                    
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        addGestureRecognizer(tapGesture)
    }
    
    
    
    
    
    
    func configure(with movie: MovieModel, year: Int, delegate: MovieNavigationDelegate) {
        self.movie = movie
        self.delegate = delegate
        
         if let url = URL(string: movie.imageUrl) {
             // Load image asynchronously
             DispatchQueue.global().async {
                 if let data = try? Data(contentsOf: url) {
                     DispatchQueue.main.async {
                         self.imageView.image = UIImage(data: data)
                     }
                 }
             }
         }
         titleLabel.text = "\(movie.name) (\(year))"
         descriptionLabel.text = movie.summary
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
