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
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "aeaf72682088a6c3c42cb003b8c0d453"
    private let acountId = "21323612"
    var watchListTableRows: [TableViewSection] = []
    
    public weak var delegate: WatchListControllerViewModelDelegate? = nil
    public weak var watchListDelegate: WatchListMovieTableViewRowItemDelegate? = nil

    func fetchWatchlistMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        guard let sessionId = UserDefaults.standard.string(forKey: "SessionID") else {
            completion(nil, CustomEror.invalidSession)
            return
        }
        
        let urlString = "https://api.themoviedb.org/3/account/\(acountId)/watchlist/movies?api_key=\(apiKey)&session_id=\(sessionId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, CustomEror.invalidUrl)
            return
        }
        
        ApiService.shared.getRequest(url: url, expecting: WatchlistResponse.self) { result in
            switch result {
            case .success(let success):
                completion(success.results, nil)
            case .failure:
                completion(nil, CustomEror.invalidResponse)
            }
        }
    }
    func fetchWatchListMoviesFromApi() async throws -> [Movie] {
        try await withCheckedThrowingContinuation{ continuation in
            fetchWatchlistMovies { movies, error in
                if let movies = movies {
                    continuation.resume(returning: movies)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: CustomEror.invalidResponse)
                }
            }
        }
    }
    
    func fetchMovieDetails(by id: Int, completion: @escaping (MovieDetails?, Error?) -> Void) {
        let urlString = "\(baseUrl)\(id)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, CustomEror.invalidUrl)
            return
        }
        
        ApiService.shared.getRequest(url: url, expecting: MovieDetails.self) { result in
            switch result {
            case .success(let movieDetails):
                completion(movieDetails, nil)
            case .failure:
                completion(nil, CustomEror.invalidResponse)
            }
        }
    }
    
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails? {
        try await withCheckedThrowingContinuation { continuation in
            fetchMovieDetails(by: id) { movieDetails, error in
                if let movieDetails = movieDetails {
                    continuation.resume(returning: movieDetails)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: CustomEror.invalidResponse)
                }
            }
        }
    }
    
    private func fetchDetailedMovies(for movies: [Movie]) async throws -> [MovieDetails] {
        var detailedMovies: [MovieDetails] = []
        
        for movie in movies {
            if let movieDetails = try await fetchMovieDetails(by: movie.id) {
                detailedMovies.append(movieDetails)
            }
        }
        
        return detailedMovies
    }
    
    func fetchData() {
        Task { @MainActor in
            do {
                let watchListMovies = try await fetchWatchListMoviesFromApi()
                let detailedMovies = try await fetchDetailedMovies(for: watchListMovies)
                passDataToTableItem(detailedMovies: detailedMovies)
            } catch {
                // Handle error
            }
        }
    }
    
    private func passDataToTableItem(detailedMovies: [MovieDetails]){
        watchListTableRows = [
            WatchListMovieSection(items: detailedMovies.map { WatchListMovieCellItem(item: $0, delegate: watchListDelegate) })
        ]
        self.delegate?.watchListControllerViewModel()
    }
}
