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
        let homeTabController = FAQsViewController(coordinator: self, viewModel: GemsFAQViewModel())
        navigationController.setViewControllers([homeTabController], animated: false)
    }
    
    
    func showMovieDetails(_ selectedMovie: Movie) {
        let movieDetailsController = MovieDetailsController(coordinator: self, viewModel: MovieDetailsViewViewModel(movie: selectedMovie))
        movieDetailsController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(movieDetailsController, animated: true)
    }
    
    func showMovieDetailsFromWatchList(_ selectedMovie: MovieDetails) {
        let movieDetailsController = MovieDetailsController(coordinator: self, viewModel: MovieDetailsViewViewModel(movieDetails: selectedMovie))
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
