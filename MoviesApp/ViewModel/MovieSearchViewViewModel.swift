//
//  MovieSearchViewViewModel.swift
//  MoviesApp
//
//  Created by Asif Hussain on 05/08/2024.
//

import Foundation

protocol MovieSearchViewViewModelDelegate: AnyObject {
    func movieSearchViewModelReloadData()
    func movieSearchViewModelNoResultsFound()
}

class MovieSearchViewViewModel: NSObject{
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    var searchResultRows: [TableViewSection] = []
    
    public weak var delegate: MovieSearchViewViewModelDelegate? = nil
    public weak var searchListDelegate: WatchListMovieTableViewRowItemDelegate? = nil
    
    // MARK: - DataRequests
    private func fetchSearchResults(with searchName: String) async throws -> [MovieResult] {
        let encodedQuery = searchName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchName
        let request = MovieSearchRequest(query: encodedQuery)
        let response = try await networkService.request(request)
        return response.results
    }
    
    private func fetchMovieDetails(by id: Int) async throws -> MovieDetails {
        let request = MovieDetailsRequest(movieId: id)
        let response = try await networkService.request(request)
        return response
    }
    
    // MARK: - Append Result data with Movie-details
    private func fetchDetailedMovies(for movies: [MovieResult]) async throws -> [MovieDetails] {
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
    
    // MARK: - Search for movie using query
    func queryMovies(with searchedName: String){
        Task{ @MainActor in
            do{
                let searchResult = try await fetchSearchResults(with: searchedName)
                if searchResult.isEmpty{
                    delegate?.movieSearchViewModelNoResultsFound()
                } else{
                    let searchedMovieDetails = try await fetchDetailedMovies(for: searchResult)
                    updateTableRowsWithData(detailedMovies: searchedMovieDetails)
                }
            } catch {
                delegate?.movieSearchViewModelNoResultsFound()
            }
        }
    }
    
    private func updateTableRowsWithData(detailedMovies: [MovieDetails]){
        searchResultRows = [
            WatchListMovieSection(items: detailedMovies.map { WatchListMovieCellItem(item: $0, delegate: searchListDelegate) })
        ]
        self.delegate?.movieSearchViewModelReloadData()
    }
}
