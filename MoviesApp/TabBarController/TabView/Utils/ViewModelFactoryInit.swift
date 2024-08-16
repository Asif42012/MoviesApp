//
//  ViewModelFactoryInit.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import Foundation

class ViewModelFactoryInitializer {
    static func initializeViewModelFactory() -> MovieViewModelFactory {
        let networkService = DefaultNetworkService()
        let authService = DefaultAuthService(networkService: networkService)
        let movieService = DefaultMovieService(networkService: networkService)
        let watchListMovieService = DefaultWatchListMovieService(networkService: networkService, authService: authService)
        let searchMovieService = DefaultSearchMovieService(networkService: networkService)
        return DefaultMovieViewModelFactory(
            movieService: movieService,
            searchMovieService: searchMovieService,
            watchListMovieService: watchListMovieService
        )
    }
}

