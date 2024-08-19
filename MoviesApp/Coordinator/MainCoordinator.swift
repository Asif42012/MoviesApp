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
        let homeTabController = MovieTabBarController(coordinator: self)
        navigationController.setViewControllers([homeTabController], animated: false)
    }
    
    
    func showMovieDetails(_ selectedMovie: Movie) {
        let networkService = DefaultNetworkService()
        let authService = DefaultAuthService(networkService: networkService)
        let movieDetailsService = DefaultMovieDetailsService(networkService: networkService, authService: authService)
        let viewModel = MovieDetailsViewViewModel(movie: selectedMovie, movieDetailsService: movieDetailsService, authService: authService)
        
        let movieDetailsController = MovieDetailsController(coordinator: self, viewModel: viewModel)
        movieDetailsController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(movieDetailsController, animated: true)
    }

    func showMovieDetailsFromWatchList(_ selectedMovie: MovieDetails) {
        let networkService = DefaultNetworkService()
        let authService = DefaultAuthService(networkService: networkService)
        let viewModel = MovieDetailsViewViewModel(movieDetails: selectedMovie, authService: authService, networkService: networkService)
        
        let movieDetailsController = MovieDetailsController(coordinator: self, viewModel: viewModel)
        movieDetailsController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(movieDetailsController, animated: true)
    }
    
    func showSearchTabAndActivateSearchBar() {
        if let tabBarController = self.navigationController.viewControllers.first(where: { $0 is MovieTabBarController }) as? MovieTabBarController {
            tabBarController.selectedIndex = 1
        }
    }
    
    func showFAQs() {
        let faqsController = FAQsViewController(coordinator: self, viewModel: GemsFAQViewModel())
        faqsController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(faqsController, animated: true)
    }

    func popViewController() {
        navigationController.popViewController(animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
