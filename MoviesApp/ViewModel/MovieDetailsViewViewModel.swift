//
//  MovieDetailsViewViewModel.swift
//  MoviesApp
//
//  Created by Asif Hussain on 29/07/2024.
//

import Foundation
import UIKit

protocol MovieDetailsViewViewModelDelegate: AnyObject {
    func movieDetailsViewViewModelReloadData()
}

class MovieDetailsViewViewModel:NSObject {
    
    private let networkService: NetworkService = DefaultNetworkService()
    var tableSections: [TableViewSection] = []
    var collectionViewSections: [CollectionViewFlowSection] = []
    
    public weak var delegate: MovieDetailsViewViewModelDelegate? = nil
    private static var watchlistIds: Set<Int> = []
    
    var backdropPath: String
    var genres: [Genre]
    var id: Int
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String
    var releaseDate: String
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    var runtime: Int
    
    init(backdropPath: String, genres: [Genre], id: Int, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int, runtime: Int) {
        self.backdropPath = backdropPath
        self.genres = genres
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.runtime = runtime
    }
    // MARK: - for movies
    convenience init(movie: Movie) {
        self.init(
            backdropPath: movie.backdropPath,
            genres: [],
            id: movie.id,
            originalTitle: movie.originalTitle,
            overview: movie.overview,
            popularity: movie.popularity,
            posterPath: movie.posterPath,
            releaseDate: movie.releaseDate,
            title: movie.title,
            video: movie.video,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
            runtime: 0
        )
    }
    
    // MARK: - for movie details
    convenience init(movieDetails: MovieDetails) {
        self.init(
            backdropPath: movieDetails.backdropPath,
            genres: movieDetails.genres,
            id: movieDetails.id,
            originalTitle: movieDetails.originalTitle,
            overview: movieDetails.overview,
            popularity: movieDetails.popularity,
            posterPath: movieDetails.posterPath,
            releaseDate: movieDetails.releaseDate,
            title: movieDetails.title,
            video: movieDetails.video,
            voteAverage: movieDetails.voteAverage,
            voteCount: movieDetails.voteCount,
            runtime: movieDetails.runtime
        )
    }
    
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
    
    private func fetchMovieCast() async throws -> [Cast] {
        let request = MovieCastRequest(id: id)
        let response = try await networkService.request(request)
        let movieCast = response.cast
        return movieCast
    }
    
    private func fetchMovieReviews() async throws -> [Review] {
        let request = MovieReviewRequest(id: id)
        let response = try await networkService.request(request)
        let movieReviews = response.results
        return movieReviews
    }
    
    private func addMovieToWatchList(movieId: Int) async throws -> Bool {
        let sessionId = try await getSessionId()
        let request = AddToWatchList(sessionId: sessionId, mediaType: "movie", mediaId: movieId, watchlist: true)
        let response = try await networkService.request(request)
        if response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13 {
            return true
        } else {
            throw CustomError.invalidResponse
        }
    }
    
    func rateMovie(rating: Double) async throws -> Bool {
        let sessionId = try await getSessionId()
        let request = RateMovieRequest(id: id, sessionId: sessionId, rating: rating)
        let response = try await networkService.request(request)
        if response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13 {
            return true
        } else {
            throw CustomError.invalidResponse
        }
    }
    
    func fetchMovieDetails() async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: id)
        let response = try await networkService.request(request)
        self.backdropPath = response.backdropPath
        self.posterPath = response.posterPath
        self.title = response.title
        self.releaseDate = response.releaseDate
        self.runtime = response.runtime
        self.genres = response.genres
        self.voteAverage = response.voteAverage
        self.overview = response.overview
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
    
    // Method to fetch and store watchlist IDs
    func loadWatchlistIds(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let movies = try await fetchWatchListMovies()
                MovieDetailsViewViewModel.watchlistIds = Set(movies.map { $0.id })
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
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
    
    // Save movie to watchlist
    func saveCurrentMovieAsync() async -> Result<Bool, Error> {
        do {
            let movieDetails = try await fetchMovieDetails()
            let currentMovieId = movieDetails.id
            
            // Check if the movie is already in the watchlist
            if MovieDetailsViewViewModel.watchlistIds.contains(currentMovieId) {
                return .success(false)  // Movie already exists
            }
            
            // Add movie to watchlist
            let success = try await addMovieToWatchList(movieId: currentMovieId)
            
            if success {
                MovieDetailsViewViewModel.watchlistIds.insert(currentMovieId)
                return .success(true)
            } else {
                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to add movie to watchlist"]))
            }
        } catch {
            return .failure(error)
        }
    }
    
    func fetchData() {
        Task{ @MainActor in
            do {
                let castData = try await fetchMovieCast()
                let reviewData = try await fetchMovieReviews()
                passDataToTableItem(cast: castData,userReview: reviewData)
            } catch {
                
            }
        }
    }
    
    private func passDataToTableItem(cast: [Cast], userReview: [Review]){
        let reviewItems = userReview.map { MovieReviewCellItem(item: $0) }
        let reviewSection = MovieReviewsSection(items: reviewItems)
        tableSections = [reviewSection]
        let castItems = cast.map{ CastViewCellItem(item: $0) }
        let castSection = CastViewFlow(items: castItems)
        collectionViewSections = [castSection]
        self.delegate?.movieDetailsViewViewModelReloadData()
    }
}

