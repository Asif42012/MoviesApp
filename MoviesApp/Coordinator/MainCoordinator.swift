//
//  MainCoordinator.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import Foundation
import UIKit


class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let homeTabController = MovieTabBarController()
        homeTabController.coordinator = self
        homeTabController.configureTabs()
        print("Setting coordinator: \(self)")
        navigationController.setViewControllers([homeTabController], animated: false)
    }
    
    
    func showMovieDetails(_ selectedMovie: Movie) {
        let movieDetailsController = MovieDetailsController(viewModel: MovieDetailsViewViewModel(movie: selectedMovie))
        movieDetailsController.coordinator = self
        movieDetailsController.hidesBottomBarWhenPushed = true
        print("Pushing MovieDetailsController onto navigation stack")
        navigationController.pushViewController(movieDetailsController, animated: true)
    }
    
    func showMovieDetailsFromWatchList(_ selectedMovie: MovieDetails) {
        let movieDetailsController = MovieDetailsController(viewModel: MovieDetailsViewViewModel(movieDetails: selectedMovie))
        movieDetailsController.coordinator = self
        movieDetailsController.hidesBottomBarWhenPushed = true
        print("Pushing MovieDetailsController onto navigation stack")
        navigationController.pushViewController(movieDetailsController, animated: true)
    }
    
    func showSearchTabAndActivateSearchBar() {
        // Assuming the coordinator has a reference to the current UITabBarController
        if let tabBarController = self.navigationController.viewControllers.first(where: { $0 is MovieTabBarController }) as? MovieTabBarController {
            tabBarController.selectedIndex = 1
            
            // Optionally, you can access the search controller and activate the search bar if needed
            if let searchNavController = tabBarController.viewControllers?[1] as? UINavigationController,
               let searchViewController = searchNavController.topViewController as? MovieSearchController {
                searchViewController.searchBar.becomeFirstResponder()
            }
        }
    }

    
    func popViewController() {
        navigationController.popViewController(animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
