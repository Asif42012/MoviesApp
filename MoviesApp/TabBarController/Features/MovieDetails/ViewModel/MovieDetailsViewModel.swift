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
    private let movieDetailsService: MovieDetailsService
    private let authService: MovieAuthService
    
    var tableSections: [TableViewSection] = []
    var collectionViewSections: [CollectionViewFlowSection] = []
    
    public weak var delegate: MovieDetailsViewViewModelDelegate? = nil
    private static var watchlistIds: Set<Int> = []
    var movie: Movie
    var movieDetails: MovieDetails?
    
    init(movie: Movie, movieDetailsService: MovieDetailsService, authService: MovieAuthService) {
        self.movie = movie
        self.movieDetailsService = movieDetailsService
        self.authService = authService
        self.movieDetails = nil
        super.init()
    }
    
    convenience init(movieDetails: MovieDetails, authService: MovieAuthService, networkService: NetworkService) {
        let movie = movieDetails.toMovie()
        let movieDetailsService = DefaultMovieDetailsService(networkService: networkService, authService: authService)
        self.init(movie: movie, movieDetailsService: movieDetailsService, authService: authService)
        self.movieDetails = movieDetails
    }
    
    // Save movie to watchlist
    func saveCurrentMovieAsync() async throws-> Bool {
        do {
            let movieDetails = try await movieDetailsService.fetchMovieDetails(movieId: movie.id)
            
            let currentMovieId = movieDetails.id
            
            if MovieDetailsViewViewModel.watchlistIds.contains(currentMovieId) {
                print("Movie Already Exist")
                return false  // Movie already exists
            }
            
            let success = try await movieDetailsService.addMovieToWatchList(movieId: currentMovieId)
            if success == true {
                MovieDetailsViewViewModel.watchlistIds.insert(currentMovieId)
                return true
            } else {
                print("Error occurred while adding movie to watchlist")
                return false
            }
            
            
        } catch {
            print("Function execution Failed \(error)")
            return false
        }
    }
    
    func rateMovie(rating: Double) async throws -> Bool {
        do {
            let rating = try await movieDetailsService.rateMovie(movieId: movie.id, rating: rating)
            if rating == true {
                return true
            } else {
                print("Invalid response while rating")
                return false
            }
        } catch {
            print("Unable to rate movie due to \(error)")
            return false
        }
    }
    
    func fetchData() {
        Task{ @MainActor in
            do {
                let movieDetails = try await movieDetailsService.fetchMovieDetails(movieId: movie.id)
                self.movieDetails = movieDetails
                let movies = try await movieDetailsService.fetchWatchListMovies()
                MovieDetailsViewViewModel.watchlistIds = Set(movies.map { $0.id })
                let castData = try await movieDetailsService.fetchMovieCast(movieId: movie.id)
                let reviewData = try await movieDetailsService.fetchMovieReviews(movieId: movie.id)
                passDataToTableItem(cast: castData,userReview: reviewData)
            } catch {
                print("Error while fetching \(error)")
            }
        }
    }
    
    private func passDataToTableItem(cast: [Cast], userReview: [MovieReview]){
        let reviewItems = userReview.map { MovieReviewCellItem(item: $0) }
        let reviewSection = MovieReviewsSection(items: reviewItems)
        tableSections = [reviewSection]
        let castItems = cast.map{ CastViewCellItem(item: $0) }
        let castSection = CastViewFlow(items: castItems)
        collectionViewSections = [castSection]
        self.delegate?.movieDetailsViewViewModelReloadData()
    }
}

