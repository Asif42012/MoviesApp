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
    
    //Network Layer approach//
    private func createRequestToken() async throws -> RequestTokenResponse {
        let request = CreateTokenRequest()
        let response = try await networkService.request(request)
        return response
    }
    
    private func createSession(requestToken: String) async throws -> CreateSessionResponse {
        let request = CreateSessionRequest(requestToken: requestToken)
        let response = try await networkService.request(request)
        UserDefaults.standard.set(response.sessionId, forKey: "SessionID")
        return response
    }
    
    
    private func authenticateRequestToken(requestToken: String) {
        let request = AuthenticationRequest(requestToken: requestToken)
        guard let url = request.url else {
            print("Invalid URL")
            return
        }
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
    
    private func getSessionId() async throws -> String {
        if let sessionId = UserDefaults.standard.string(forKey: "SessionID") {
            return sessionId
        } else {
            // Create a new session ID if not available
            let requestToken = try await createRequestToken()
            authenticateRequestToken(requestToken: requestToken.requestToken)
            
            // Wait for user to authenticate, then create session
            try await Task.sleep(nanoseconds: 30 * 1_000_000_000) // 60 seconds
            let sessionId = try await createSession(requestToken: requestToken.requestToken)
            return sessionId.sessionId
        }
    }
    
    // MARK: - Data Request
    func fetchMovieDetails(by id: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: id)
        return try await networkService.request(request)
    }
    
    func fetchWatchListMovies() async throws -> [Movie] {
        let sessionId = try await getSessionId()
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
