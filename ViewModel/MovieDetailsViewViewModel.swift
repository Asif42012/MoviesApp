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
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "aeaf72682088a6c3c42cb003b8c0d453"
    private let acountId = "21323612"
    
    var tableSections: [TableViewSection] = []
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
    // MARK: - Movie Details Functions
    // Method to fetch detailed movie data
    func fetchMovieDetails(completion: @escaping (MovieDetails?, Error?) -> Void) {
        let urlString = "\(baseUrl)\(id)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, CustomEror.invalidUrl)
            return
        }
        ApiService.shared.getRequest(url: url, expecting: MovieDetails.self) { result in
            switch result {
            case .success(let movieDetails):
                self.backdropPath = movieDetails.backdropPath
                self.posterPath = movieDetails.posterPath
                self.title = movieDetails.title
                self.releaseDate = movieDetails.releaseDate
                self.runtime = movieDetails.runtime
                self.genres = movieDetails.genres
                self.voteAverage = movieDetails.voteAverage
                self.overview = movieDetails.overview
                completion(movieDetails, nil)
            case .failure:
                completion(nil, CustomEror.invalidResponse)
            }
        }
    }
    
    // MARK: - Auth functions
    private func createRequestToken(completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomEror.invalidUrl))
            return
        }
        
        ApiService.shared.getRequest(url: url, expecting: RequestTokenResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.requestToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func authenticateRequestToken(requestToken: String) {
        let urlString = "https://www.themoviedb.org/authenticate/\(requestToken)"
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func createSession(requestToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomEror.invalidUrl))
            return
        }
        let body = CreateSessionRequest(requestToken: requestToken)
        ApiService.shared.postRequest(url: url, body: body, expecting: CreateSessionResponse.self) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.sessionId, forKey: "SessionID")
                completion(.success(response.sessionId))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getSessionId(completion: @escaping (String?) -> Void) {
        if let sessionId = UserDefaults.standard.string(forKey: "SessionID") {
            completion(sessionId)
        } else {
            // Create a new session ID if not available
            createRequestToken { result in
                switch result {
                case .success(let requestToken):
                    self.authenticateRequestToken(requestToken: requestToken)
                    // Wait for user to authenticate, then create session
                    DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                        self.createSession(requestToken: requestToken) { sessionResult in
                            switch sessionResult {
                            case .success(let sessionId):
                                completion(sessionId)
                            case .failure:
                                completion(nil)
                            }
                        }
                    }
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    // MARK: - fetch user Reviews for current movie
    // Method to fetch user reviews
    func fetchUserReviews(completion: @escaping ([Review]?, Error?) -> Void) {
        let urlString = "\(baseUrl)\(id)/reviews?api_key=\(apiKey)"
        guard let url = URL(string: urlString)  else {
            completion(nil, CustomEror.invalidUrl)
            return
        }
        
        ApiService.shared.getRequest(url: url, expecting: ReviewsResponse.self) { result in
            switch result {
            case .success(let reviewsResponse):
                completion(reviewsResponse.results, nil)
            case .failure:
                completion(nil, CustomEror.invalidResponse)
            }
        }
    }
    
    // MARK: - add Movie to watchlist
    func addToWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        getSessionId { sessionId in
            guard let sessionId = sessionId else {
                completion(.failure(CustomEror.invalidSession))
                return
            }
            
            let urlString = "https://api.themoviedb.org/3/account/\(self.acountId)/watchlist?api_key=\(self.apiKey)&session_id=\(sessionId)"
            guard let url = URL(string: urlString) else {
                completion(.failure(CustomEror.invalidUrl))
                return
            }
            
            let requestBody = AddToWatchlistRequest(mediaType: "movie", mediaId: movieId, watchlist: true)
            
            ApiService.shared.postRequest(url: url, body: requestBody, expecting: APIResponse.self) { result in
                switch result {
                case .success(let response):
                    if response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13 {
                        completion(.success(true))
                    } else {
                        completion(.failure(CustomEror.invalidResponse))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Method to fetch and store watchlist IDs
    func loadWatchlistIds(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let movies = try await fetchWatchListMoviesFromApi()
                MovieDetailsViewViewModel.watchlistIds = Set(movies.map { $0.id })
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
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
    // Save movie to watchlist
    func saveCurrentMovieAsync(completion: @escaping (Result<Bool, Error>) -> Void) {
        Task { @MainActor in
            do {
                guard let movieDetails = try await fetchMovieDetails() else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Movie"])))
                    return
                }
                let currentMovieId = movieDetails.id
                if MovieDetailsViewViewModel.watchlistIds.contains(currentMovieId) {
                    completion(.success(false))  // Movie already exists
                    return
                }
                addToWatchlist(movieId: currentMovieId) { result in
                    switch result {
                    case .success(let success):
                        if success {
                            MovieDetailsViewViewModel.watchlistIds.insert(currentMovieId)
                            completion(.success(true))
                        } else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to add movie to watchlist"])))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - movie details Async functions
    func fetchMovieDetails() async throws -> MovieDetails? {
        try await withCheckedThrowingContinuation{ continuation in
            fetchMovieDetails { (movieDetails, error )in
                if let movieDetails  = movieDetails {
                    continuation.resume(returning: movieDetails)
                } else if let error = error {
                    continuation.resume(throwing: error)
                }
                else{
                    continuation.resume(throwing: CustomEror.invalidResponse)
                }
            }
        }
    }
    
    // MARK: - fetch user reviews for current movie asyn function
    func fetchUserReviews() async throws -> [Review] {
        try await withCheckedThrowingContinuation{ continuation in
            fetchUserReviews { (reviews, error) in
                if let reviews = reviews {
                    continuation.resume(returning: reviews)
                }else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: CustomEror.invalidResponse)
                }
            }
        }
    }
    
    // MARK: - movie watchlist Async functions
    func fetchWatchListMoviesFromApi() async throws -> [Movie] {
        try await withCheckedThrowingContinuation { continuation in
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
    
    func rateMovie(rating: Double, completion: @escaping (Result<Bool, Error>) -> Void) {
        getSessionId { sessionId in
            guard let sessionId = sessionId else {
                completion(.failure(CustomEror.invalidSession))
                return
            }
            
            let urlString = "https://api.themoviedb.org/3/movie/\(self.id)/rating?api_key=\(self.apiKey)&session_id=\(sessionId)"
            guard let url = URL(string: urlString) else {
                completion(.failure(CustomEror.invalidUrl))
                return
            }
            
            let requestBody = RateMovieRequest(value: rating)
            
            ApiService.shared.postRequest(url: url, body: requestBody, expecting: APIResponse.self) { result in
                switch result {
                case .success(let response):
                    if response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13 {
                        completion(.success(true))
                    } else {
                        completion(.failure(CustomEror.invalidResponse))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchData() {
        Task{ @MainActor in
            do {
                let reviewData = try await fetchUserReviews()
                passDataToTableItem(userReview: reviewData)
            } catch {
                
            }
        }
    }
    
    private func passDataToTableItem(userReview: [Review]){
        let reviewItems = userReview.map { MovieReviewCellItem(item: $0) }
        let reviewSection = MovieReviewsSection(items: reviewItems)
        tableSections = [reviewSection]
        self.delegate?.movieDetailsViewViewModelReloadData()
    }
}

