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

class WatchListControllerViewModel: NSObject{
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    var watchListTableRows: [TableViewSection] = []
    
    public weak var delegate: WatchListControllerViewModelDelegate? = nil
    public weak var watchListDelegate: WatchListMovieTableViewRowItemDelegate? = nil
    
    // MARK: - Data Request
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: id)
        return try await networkService.request(request)
    }
    
    func fetchWatchListMovies() async throws -> [Movie] {
        guard let sessionId = UserDefaults.standard.string(forKey: "SessionID") else {
            throw CustomError.invalidSession
        }
        let request = WatchListMoviesRequest(sessionId: sessionId)
        let response = try await networkService.request(request)
        let watchListResponse = response.results
        return watchListResponse
    }
    
    // MARK: - Append Movie details with movie
    private func fetchDetailedMovies(for movies: [Movie]) async throws -> [MovieDetails] {
        var detailedMovies: [MovieDetails] = []
        for movie in movies {
            do {
                let movieDetails = try await fetchMovieDetails(by: movie.id)
                detailedMovies.append(movieDetails)
            } catch {
                print("Failed to fetch details for movie ID \(movie.id): \(error.localizedDescription)")
                throw error
            }
        }
        return detailedMovies
    }
    
    func fetchData() {
        Task { @MainActor in
            do {
                let watchListRequest = try await fetchWatchListMovies()
                let detailedMovies = try await fetchDetailedMovies(for: watchListRequest)
                updateTableRowsWithData(detailedMovies: detailedMovies)
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
    }
    
    private func updateTableRowsWithData(detailedMovies: [MovieDetails]){
        watchListTableRows = [
            WatchListMovieSection(items: detailedMovies.map { WatchListMovieCellItem(item: $0, delegate: watchListDelegate) })
        ]
        self.delegate?.watchListControllerViewModel()
    }
}
