//
//  MovieListHeaderView.swift
//  movieApp
//
//  Created by <3 on 18.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData




class MovieListHeaderView: UICollectionReusableView {
    let titleLabel: UILabel
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 30, left: 10, bottom: 0 ,right: 10))
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        titleLabel.textColor =  UIColor(red: 15/255.0, green: 32/255.0, blue: 56/255.0, alpha: 1.0)
        titleLabel.backgroundColor = .clear
        //UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
