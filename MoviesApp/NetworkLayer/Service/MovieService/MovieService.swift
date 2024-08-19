//
//  MovieService.swift
//  MoviesApp
//
//  Created by Asif Hussain on 14/08/2024.
//

import Foundation

protocol MovieService {
    func fetchMovies(from endpoint: EndPoints) async throws -> [Movie]
}

final class DefaultMovieService: MovieService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    internal func fetchMovies(from endpoint: EndPoints) async throws -> [Movie] {
        let request = MoviesRequest(endpoint: endpoint)
        let response = try await networkService.request(request)
        return response.results
    }
}
