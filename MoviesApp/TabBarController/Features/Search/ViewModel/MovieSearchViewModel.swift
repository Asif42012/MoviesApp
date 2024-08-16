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

class MovieSearchViewViewModel: NSObject, MovieSearchViewDataSource {
    private let searchMovieService: SearchMovieService
    private let networkService: NetworkService = DefaultNetworkService()
    var tableRows: [TableViewSection] = []
    
    public weak var delegate: MovieSearchViewViewModelDelegate? = nil
    public weak var searchListDelegate: WatchListMovieTableViewRowItemDelegate? = nil
    
    init(searchMovieService: SearchMovieService) {
        self.searchMovieService = searchMovieService
    }

    // MARK: - Search for movie using query
    func queryMovies(with searchedName: String){
        Task{ @MainActor in
            do{
                let searchResult = try await searchMovieService.fetchSearchResults(with: searchedName)
                if searchResult.isEmpty{
                    delegate?.movieSearchViewModelNoResultsFound()
                } else{
                    let searchedMovieDetails = try await searchMovieService.fetchDetailedMovies(for: searchResult)
                    updateTableRowsWithData(detailedMovies: searchedMovieDetails)
                    delegate?.movieSearchViewModelReloadData()
                }
            } catch {
                delegate?.movieSearchViewModelNoResultsFound()
            }
        }
    }
    
    private func updateTableRowsWithData(detailedMovies: [MovieDetails]){
        tableRows = [
            WatchListMovieSection(items: detailedMovies.map { WatchListMovieCellItem(item: $0, delegate: searchListDelegate) })
        ]
        self.delegate?.movieSearchViewModelReloadData()
    }
}
