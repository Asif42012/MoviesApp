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
    private let apiKey = "aeaf72682088a6c3c42cb003b8c0d453"
    private let baseUrl = "https://api.themoviedb.org/3/search/movie?query="
    private let baseUrlDetails = "https://api.themoviedb.org/3/movie/"
    var searchResultRows: [TableViewSection] = []
    
    public weak var delegate: MovieSearchViewViewModelDelegate? = nil
    
    public weak var searchListDelegate: WatchListMovieTableViewRowItemDelegate? = nil
    
    private func fetchSearchResults(with searchedName: String, completion: @escaping ([MovieResult]?, Error?) -> Void){
        let encodedQuery = searchedName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchedName
        let urlString = "\(baseUrl)\(encodedQuery)&api_key=\(apiKey)"
        print("Complete Url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            completion(nil,CustomEror.invalidUrl)
            print("Invalid Url from fetched")
            return
        }
        
        ApiService.shared.getRequest(url: url, expecting: SearchMovieResponce.self){ result in
            switch result {
            case .success(let responce):
                completion(responce.results, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchSearchedMovie(with searchedName: String) async throws ->[MovieResult] {
        try await withCheckedThrowingContinuation{ continuation in
            fetchSearchResults(with: searchedName) { searchResult, error in
                if let searchResult = searchResult {
                    continuation.resume(returning: searchResult)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: CustomEror.invalidResponse)
                }
            }
        }
    }
    
    func fetchMovieDetails(by id: Int, completion: @escaping (MovieDetails?, Error?) -> Void) {
        let urlString = "\(baseUrlDetails)\(id)?api_key=\(apiKey)"
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
    
    private func fetchDetailedMovies(for movies: [MovieResult]) async throws -> [MovieDetails] {
        var detailedMovies: [MovieDetails] = []
        
        for movie in movies {
            do {
                if let movieDetails = try await fetchMovieDetails(by: movie.id) {
                    print("Fetched details for movie ID: \(movie.id) - \(movieDetails)")
                    detailedMovies.append(movieDetails)
                } else {
                    print("No details found for movie ID: \(movie.id)")
                }
            } catch {
                print("Error fetching details for movie ID: \(movie.id) - \(error)")
            }
        }
        
        print("Details Movie Data is \(detailedMovies)")
        return detailedMovies
    }
    
    
    func queryMovies(with searchedName: String){
        Task{ @MainActor in
            do{
                let searchResult = try await fetchSearchedMovie(with: searchedName)
                if searchResult.isEmpty{
                    delegate?.movieSearchViewModelNoResultsFound()
                } else{
                    let searchedMovieDetails = try await fetchDetailedMovies(for: searchResult)
                    print("THis is details of SearchMoviee<-------> \(searchedMovieDetails)<---------->")
                    passDataToTableItem(detailedMovies: searchedMovieDetails)
                }
               
            } catch {
                delegate?.movieSearchViewModelNoResultsFound()
            }
        }
    }
    
    private func passDataToTableItem(detailedMovies: [MovieDetails]){
        searchResultRows = [
            WatchListMovieSection(items: detailedMovies.map { WatchListMovieCellItem(item: $0, delegate: searchListDelegate) })
        ]
        self.delegate?.movieSearchViewModelReloadData()
    }
}
