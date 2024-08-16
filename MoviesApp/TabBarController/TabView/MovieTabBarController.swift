//
//  MovieTabBarController.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import UIKit

class MovieTabBarController: UITabBarController {
    private let coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        configureUI()
    }
    
    private func configureTabs() {
        let viewModelFactory = ViewModelFactoryInitializer.initializeViewModelFactory()
        let tabSetup = TabBarSetup(coordinator: coordinator, viewModelFactory: viewModelFactory)
        setViewControllers(tabSetup.createViewControllers(), animated: false)
    }
    
    private func configureUI() {
        let uiConfigurator = TabBarUIConfigurator()
        uiConfigurator.configureAppearance()
    }
}

