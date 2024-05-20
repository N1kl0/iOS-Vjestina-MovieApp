//
//  MainTabBarController.swift
//  movieApp
//
//  Created by <3 on 19.05.2024..
//

import Foundation
import UIKit



import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let movieListViewController = MovieListViewController()
        movieListViewController.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "house"), tag: 0)
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        
        let movieListNavController = UINavigationController(rootViewController: movieListViewController)
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        
        viewControllers = [movieListNavController, favoritesNavController]
    }
}
