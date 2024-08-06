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
        let movieDetailsController = MovieDetailsController()
        movieDetailsController.coordinator = self
        movieDetailsController.hidesBottomBarWhenPushed = true
        movieDetailsController.viewModel = MovieDetailsViewViewModel(movie: selectedMovie)
        print("Pushing MovieDetailsController onto navigation stack")
        navigationController.pushViewController(movieDetailsController, animated: true)
    }
    
    func showMovieDetailsFromWatchList(_ selectedMovie: MovieDetails) {
        let movieDetailsController = MovieDetailsController()
        movieDetailsController.coordinator = self
        movieDetailsController.hidesBottomBarWhenPushed = true
        movieDetailsController.viewModel = MovieDetailsViewViewModel(movieDetails: selectedMovie)
        print("Pushing MovieDetailsController onto navigation stack")
        navigationController.pushViewController(movieDetailsController, animated: true)
    }
    
    func showSearchTabAndActivateSearchBar() {
        let homeTabController = MovieTabBarController()
        homeTabController.coordinator = self
        homeTabController.selectedIndex = 1
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
