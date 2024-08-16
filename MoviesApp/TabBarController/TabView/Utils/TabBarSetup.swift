//
//  TabBarSetup.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

class TabBarSetup {
    private let coordinator: MainCoordinator
    private let viewModelFactory: MovieViewModelFactory
    
    init(coordinator: MainCoordinator, viewModelFactory: MovieViewModelFactory) {
        self.coordinator = coordinator
        self.viewModelFactory = viewModelFactory
    }
    
    private let homeTabNameLabel: UILabel = LabelFactory.createTabBarLabel(withText: "Home")
    private let searchTabNameLabel: UILabel = LabelFactory.createTabBarLabel(withText: "Search")
    private let watchListTabNameLabel: UILabel = LabelFactory.createTabBarLabel(withText: "Watch List")
    
    func createViewControllers() -> [UIViewController] {
        let movieHomeVc = MovieHomeController(coordinator: coordinator, viewModel: viewModelFactory.makeMovieHomeViewModel())
        let movieSearchVc = MovieSearchController(coordinator: coordinator, viewModel: viewModelFactory.makeMovieSearchViewModel())
        let movieWatchListVc = MovieWatchListController(coordinator: coordinator, viewModel: viewModelFactory.makeWatchListViewModel())
        
        let nav1 = createNavController(vc: movieHomeVc, title: homeTabNameLabel.text ?? "Home", imageName: "Ic_home", tag: 1)
        let nav2 = createNavController(vc: movieSearchVc, title: searchTabNameLabel.text ?? "Search", imageName: "Ic_search", tag: 2)
        let nav3 = createNavController(vc: movieWatchListVc, title: watchListTabNameLabel.text ?? "Watchlist", imageName: "Ic_bookMark", tag: 3)
        
        return [nav1, nav2, nav3]
    }
    
    private func createNavController(vc: UIViewController, title: String, imageName: String, tag: Int) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), tag: tag)
        return navController
    }
}

