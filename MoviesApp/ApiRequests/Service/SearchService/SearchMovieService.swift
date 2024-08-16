//
//  SearchMovieService.swift
//  MoviesApp
//
//  Created by Asif Hussain on 15/08/2024.
//

import Foundation

protocol SearchMovieService {
    func fetchSearchResults(with searchName: String) async throws -> [MovieResult]
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails
    func fetchDetailedMovies(for movies: [MovieResult]) async throws -> [MovieDetails]
}

final class DefaultSearchMovieService: SearchMovieService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchSearchResults(with searchName: String) async throws -> [MovieResult] {
        let encodedQuery = searchName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchName
        let request = MovieSearchRequest(query: encodedQuery)
        let response = try await networkService.request(request)
        return response.results
    }
    
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: id)
        let response = try await networkService.request(request)
        return response
    }
    
    func fetchDetailedMovies(for movies: [MovieResult]) async throws -> [MovieDetails] {
        var detailedMovies: [MovieDetails] = []
        for movie in movies {
            do {
                let movieDetails = try await fetchMovieDetails(by: movie.id)
                detailedMovies.append(movieDetails)
            } catch {
                print("Error fetching details for movie ID: \(movie.id) - \(error)")
            }
        }
        return detailedMovies
    }
}
