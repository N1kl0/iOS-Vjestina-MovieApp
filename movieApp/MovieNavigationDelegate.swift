//
//  MovieNavigationDelegate.swift
//  movieApp
//
//  Created by <3 on 19.05.2024..
//

import Foundation


protocol MovieNavigationDelegate: AnyObject {
    func navigateToMovieDetails(with movieID: Int)
}
