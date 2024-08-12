//
//  MovieTabBarController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieTabBarController: UITabBarController {
    var coordinator: MainCoordinator?
    
    let homeTabNameLabel: UILabel = {
        let tabNameLabel = UILabel()
        tabNameLabel.font = AppFont.medium12
        tabNameLabel.text = "Home"
        tabNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return tabNameLabel
    }()
    
    let searchTabNameLabel: UILabel = {
        let tabNameLabel = UILabel()
        tabNameLabel.font = AppFont.medium12
        tabNameLabel.text = "Search"
        tabNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return tabNameLabel
    }()
    
    let watchListTabNameLabel: UILabel = {
        let tabNameLabel = UILabel()
        tabNameLabel.font = AppFont.medium12
        tabNameLabel.text = "Watch List"
        tabNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return tabNameLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        configureUI()
    }
    
    private func configureUI(){
        view.backgroundColor = AppFont.tabBackgroundColor
        UITabBar.appearance().barTintColor = AppFont.tabBackgroundColor
    }
    
    func configureTabs() {
        let movieHomeVc = MovieHomeController(viewModel: MovieHomeControllerViewModel())
        movieHomeVc.coordinator = coordinator
        
        let movieSearchVc = MovieSearchController(viewModel: MovieSearchViewViewModel())
        movieSearchVc.coordinator = coordinator
        
        let movieWatchListVc = MovieWatchListController(viewModel: WatchListControllerViewModel())
        movieWatchListVc.coordinator = coordinator
        
        let nav1 = UINavigationController(rootViewController: movieHomeVc)
        let nav2 = UINavigationController(rootViewController: movieSearchVc)
        let nav3 = UINavigationController(rootViewController: movieWatchListVc)
        nav1.tabBarItem = UITabBarItem(title: homeTabNameLabel.text, image: UIImage(named: "Ic_home"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: searchTabNameLabel.text, image: UIImage(named: "Ic_search"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: watchListTabNameLabel.text, image: UIImage(named: "Ic_bookMark"), tag: 3)
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}

