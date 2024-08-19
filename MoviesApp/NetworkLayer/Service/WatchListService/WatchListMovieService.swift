//
//  WatchListMovieService.swift
//  MoviesApp
//
//  Created by Asif Hussain on 15/08/2024.
//

import Foundation

protocol WatchListMovieService {
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails
    func fetchWatchListMovies() async throws -> [Movie]
    func fetchDetailedMovies(for movies: [Movie]) async throws -> [MovieDetails]
}

final class DefaultWatchListMovieService: WatchListMovieService {
    
    private let networkService: NetworkService
    private let authService: MovieAuthService
    
    init(networkService: NetworkService, authService: MovieAuthService) {
        self.networkService = networkService
        self.authService = authService
    }
    
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: id)
        return try await networkService.request(request)
    }
    
    func fetchWatchListMovies() async throws -> [Movie] {
        let sessionId = try await authService.getSessionId()
        let request = WatchListMoviesRequest(sessionId: sessionId)
        let response = try await networkService.request(request)
        let watchListResponse = response.results
        return watchListResponse
    }
    
    func fetchDetailedMovies(for movies: [Movie]) async throws -> [MovieDetails] {
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
}
