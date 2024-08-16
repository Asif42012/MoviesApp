//
//  WatchListMovieViewViewModel.swift
//  MoviesApp
//
//  Created by Asif Hussain on 01/08/2024.
//

import Foundation
import UIKit


protocol WatchListControllerViewModelDelegate: AnyObject{
    func watchListControllerViewModel()
}

class WatchListControllerViewModel: NSObject, MovieSearchViewDataSource {
    
    private let networkService: NetworkService = DefaultNetworkService()
    private let movieWatchListService: WatchListMovieService
    
    var tableRows: [TableViewSection] = []
    public weak var delegate: WatchListControllerViewModelDelegate? = nil
    public weak var watchListDelegate: WatchListMovieTableViewRowItemDelegate? = nil
    
    init(movieWatchListService: WatchListMovieService) {
        self.movieWatchListService = movieWatchListService
    }
    
    func fetchData() {
        Task { @MainActor in
            do {
                let watchListRequest = try await movieWatchListService.fetchWatchListMovies()
                let detailedMovies = try await movieWatchListService.fetchDetailedMovies(for: watchListRequest)
                updateTableRowsWithData(detailedMovies: detailedMovies)
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
    }
    
    private func updateTableRowsWithData(detailedMovies: [MovieDetails]){
        tableRows = [
            WatchListMovieSection(items: detailedMovies.map {
                WatchListMovieCellItem(item: $0, delegate: watchListDelegate)
            })
        ]
        self.delegate?.watchListControllerViewModel()
    }
}
