//
//  ViewModelFactory.swift
//  MoviesApp
//
//  Created by Asif Hussain on 14/08/2024.
//

import Foundation

protocol MovieViewModelFactory {
    func makeMovieHomeViewModel() -> MovieHomeControllerViewModel
    func makeMovieSearchViewModel() -> MovieSearchViewViewModel
    func makeWatchListViewModel() -> WatchListControllerViewModel
}
