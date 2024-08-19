//
//  MovieDetailService.swift
//  MoviesApp
//
//  Created by Asif Hussain on 18/08/2024.
//

import Foundation

protocol MovieDetailsService {
    func fetchMovieCast(movieId: Int) async throws -> [Cast]
    func fetchMovieReviews(movieId: Int) async throws -> [MovieReview]
    func addMovieToWatchList(movieId: Int) async throws -> Bool
    func rateMovie(movieId: Int, rating: Double) async throws -> Bool
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails
    func fetchWatchListMovies() async throws -> [Movie]
    
}

final class DefaultMovieDetailsService: MovieDetailsService {
    func fetchWatchListMovies() async throws -> [Movie] {
        guard let sessionId = UserDefaults.standard.string(forKey: "SessionID") else {
            throw CustomError.invalidSession
        }
        let request = WatchListMoviesRequest(sessionId: sessionId)
        let response = try await networkService.request(request)
        let watchListResponse = response.results
        return watchListResponse
    }
    
    
    private let networkService: NetworkService
    private let authService: MovieAuthService
    
    init(networkService: NetworkService, authService: MovieAuthService) {
        self.networkService = networkService
        self.authService = authService
    }
    
    func fetchMovieCast(movieId: Int) async throws -> [Cast] {
        let request = MovieCastRequest(id: movieId)
        let response = try await networkService.request(request)
        let movieCast = response.cast
        return movieCast
    }
    
    func fetchMovieReviews(movieId: Int) async throws -> [MovieReview] {
        let request = MovieReviewRequest(id: movieId)
        let response = try await networkService.request(request)
        let movieReviews = response.results
        return movieReviews
    }
    
    func addMovieToWatchList(movieId: Int) async throws -> Bool {
        let sessionId = try await authService.getSessionId()
        let request = AddToWatchList(sessionId: sessionId, mediaType: "movie", mediaId: movieId, watchlist: true)
        let response = try await networkService.request(request)
        if response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13 {
            return true
        } else {
            throw CustomError.invalidResponse
        }
    }
    
    func rateMovie(movieId: Int, rating: Double) async throws -> Bool {
        let sessionId = try await authService.getSessionId()
        let request = RateMovieRequest(id: movieId, sessionId: sessionId, rating: rating)
        let response = try await networkService.request(request)
        if response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13 {
            return true
        } else {
            throw CustomError.invalidResponse
        }
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: movieId)
        let response = try await networkService.request(request)
        return response
    }
}
