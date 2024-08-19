//
//  MovieViewModelFactory.swift
//  MoviesApp
//
//  Created by Asif Hussain on 14/08/2024.
//

import Foundation

final class DefaultMovieViewModelFactory: MovieViewModelFactory {
    private let movieService: MovieService
    private let searchMovieService: SearchMovieService
    private let watchListMovieService: WatchListMovieService
    
    init(movieService: MovieService, searchMovieService: SearchMovieService, watchListMovieService: WatchListMovieService) {
        self.movieService = movieService
        self.searchMovieService = searchMovieService
        self.watchListMovieService = watchListMovieService
    }
    
    func makeMovieHomeViewModel() -> MovieHomeControllerViewModel {
        return MovieHomeControllerViewModel(movieService: movieService)
    }
    
    func makeMovieSearchViewModel() -> MovieSearchViewViewModel {
        return MovieSearchViewViewModel(searchMovieService: searchMovieService)
    }
    
    func makeWatchListViewModel() -> WatchListControllerViewModel {
        return WatchListControllerViewModel(movieWatchListService: watchListMovieService)
    }
}
