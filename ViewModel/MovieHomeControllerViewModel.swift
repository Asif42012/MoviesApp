//
//  MovieHomeControllerViewModel.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import Foundation

protocol MovieHomeControllerViewModelDelegate: AnyObject {
    func movieHomeControllerViewModelReloadData()
}

class MovieHomeControllerViewModel: NSObject {
    private let apiKey = "aeaf72682088a6c3c42cb003b8c0d453"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    var sections: [CollectionViewSection] = []
    var discoverMovies: [Movie] = []
    var currentMovieSection: [Movie] = []
    var categoryData = [
        MovieCategory(categoryName: .nowPlaying),
        MovieCategory(categoryName: .upcoming),
        MovieCategory(categoryName: .topRated),
        MovieCategory(categoryName: .popular)
    ]
    
    public weak var delegate: MovieHomeControllerViewModelDelegate? = nil
    public weak var allMovieDelegate: AllMovieCollectionViewCellItemDelegate? = nil
    public weak var allCategorizeMovieDelegate: CategorizeMoviesCollectionViewCellItemDelegate? = nil
    public weak var allCategoryButtonsDelegate: CategoryCollectionViewCellItemDelegate? = nil
    public weak var searchBarDelegate: SearchCollectionViewCellItemDelegate? = nil
    
    // MARK: - get movies data
    private func fetchMoviesResponce(from endpoint: EndPoints, completion: @escaping ([Movie]?, Error?) -> Void) {
        let urlString = "\(baseUrl)/\(endpoint.rawValue)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, CustomEror.invalidUrl)
            return
        }
        ApiService.shared.getRequest(url: url, expecting: AllMoviesResponce.self) { result in
            switch result {
            case .success(let response):
                completion(response.results, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Async Methods
    func fetchMovies(from endpoint: EndPoints) async throws -> [Movie] {
        try await withCheckedThrowingContinuation { continuation in
            fetchMoviesResponce(from: endpoint) { (movies, error) in
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
    
    
    // MARK: - Assign fetched data to models
    func fetchData() {
        Task { @MainActor in
            do {
                sections = [
                    AllMoviesSection(headerTitle: "", items: [LoadingCellItem()]),
                    MovieCategorySection(headerTitle: "", items: [LoadingCellItem()]),
                    CategorizeMovieSection(headerTitle: "", items: [LoadingCellItem()])
                ]
                
                
                currentMovieSection = try await fetchMovies(from: .nowPlaying)
                discoverMovies = try await fetchMovies(from: .movie)
                delegate?.movieHomeControllerViewModelReloadData()
                //pass data to show in section items
                passData(
                    discoverMovies: discoverMovies,
                    movies: currentMovieSection
                )
            } catch {
                
            }
        }
    }
    
    func fetchMovieswithCategoreis(for category: MovieCategoryName) {
            Task { @MainActor in
                do {
                    switch category {
                    case .nowPlaying:
                        currentMovieSection = try await fetchMovies(from: .nowPlaying)
                        print("Result from now playing")
                    case .upcoming:
                        currentMovieSection = try await fetchMovies(from: .upcoming)
                        print("Result from upcoming")
                    case .topRated:
                        currentMovieSection = try await fetchMovies(from: .topRated)
                        print("Result from top rated")
                    case .popular:
                        currentMovieSection = try await fetchMovies(from: .popular)
                        print("Result from popular")
                    }
                    passData(discoverMovies: discoverMovies, movies: currentMovieSection)
                   self.delegate?.movieHomeControllerViewModelReloadData()
                    
                } catch {
                    print("Failed to fetch movies: \(error)")
                }
            }
        }
    //    // MARK: - pass data to views
    private func passData(discoverMovies: [Movie],movies: [Movie])
    {
        let sectioTitle = "What do you want to watch?"
        
        sections = [
            SearchSection(headerTitle: "", items: [SearchCellItem(item: sectioTitle, delegate: searchBarDelegate)]),
            AllMoviesSection(headerTitle: "", items: discoverMovies.map{ AllMoviesCellItem(item: $0, delegate: allMovieDelegate)}),
            MovieCategorySection(headerTitle: "", items: categoryData.map{ MovieCategorySectionCellItem(item: $0, delegate: allCategoryButtonsDelegate)}),
            CategorizeMovieSection(headerTitle: "", items: movies.map{
                CategorizeMovieCellItem(item: $0, delegate: allCategorizeMovieDelegate)
            })
        ]
        delegate?.movieHomeControllerViewModelReloadData()
    }
}
