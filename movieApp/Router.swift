//
//  Router.swift
//  movieApp
//
//  Created by <3 on 19.05.2024..
//

import Foundation
import UIKit



class Router {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToMovieDetails(with movieID: Int) {
        let movieDetailsViewController = MovieDetailsViewController(movieID: movieID) 
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
