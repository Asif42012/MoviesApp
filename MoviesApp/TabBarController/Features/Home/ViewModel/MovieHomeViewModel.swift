//
//  MovieHomeControllerViewModel.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import Foundation

protocol MovieHomeViewDelegate: AnyObject {
    func movieHomeViewReloadData()
}

class MovieHomeControllerViewModel: NSObject, MovieHomeViewDataSource {
    private let movieService: MovieService
    var sections: [CollectionViewSection] = []
    private var discoverMovies: [Movie] = []
    private var currentMovieSection: [Movie] = []
    
    private var categoryData = [
        MovieCategory(categoryName: .nowPlaying),
        MovieCategory(categoryName: .upcoming),
        MovieCategory(categoryName: .topRated),
        MovieCategory(categoryName: .popular)
    ]
    
    public weak var delegate: MovieHomeViewDelegate? = nil
    public weak var allMovieDelegate: AllMovieCollectionViewCellItemDelegate? = nil
    public weak var allCategorizeMovieDelegate: CategorizeMoviesCollectionViewCellItemDelegate? = nil
    public weak var allCategoryButtonsDelegate: CategoryCollectionViewCellItemDelegate? = nil
    public weak var searchBarDelegate: SearchCollectionViewCellItemDelegate? = nil
    
    init(movieService: MovieService) {
        self.movieService = movieService
        super.init()
    }
    
    func fetchMoviesWithCategories(for category: MovieCategoryName) {
        Task { @MainActor in
            do {
                switch category {
                case .nowPlaying:
                    currentMovieSection = try await movieService.fetchMovies(from: .nowPlaying)
                    print("Result from now playing")
                case .upcoming:
                    currentMovieSection = try await movieService.fetchMovies(from: .upcoming)
                    print("Result from upcoming")
                case .topRated:
                    currentMovieSection = try await movieService.fetchMovies(from: .topRated)
                    print("Result from top rated")
                case .popular:
                    currentMovieSection = try await movieService.fetchMovies(from: .popular)
                    print("Result from popular")
                }
                
                updateSectionsWithData(discoverMovies: discoverMovies,
                                       movies: currentMovieSection,
                                       selectedCategory: category)
                self.delegate?.movieHomeViewReloadData()
                
            } catch {
                print("Failed to fetch movies: \(error)")
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
                
                currentMovieSection = try await movieService.fetchMovies(from: .nowPlaying)
                discoverMovies = try await movieService.fetchMovies(from: .movie)
                delegate?.movieHomeViewReloadData()
                updateSectionsWithData(discoverMovies: discoverMovies,
                                       movies: currentMovieSection,
                                       selectedCategory: .nowPlaying)
            } catch {
                print("Failed to process Data for Movies: \(error)")
            }
        }
    }
    
    // MARK: - pass data to views
    private func updateSectionsWithData(discoverMovies: [Movie], movies: [Movie], selectedCategory: MovieCategoryName) {
        let sectionTitle = "What do you want to watch?"
        let movieCategoryItems = categoryData.map {
            MovieCategorySectionCellItem(item: $0, isSelected: selectedCategory == $0.categoryName, delegate: allCategoryButtonsDelegate)
        }
        
        sections = [
            SearchSection(headerTitle: "", items: [SearchCellItem(item: sectionTitle, delegate: searchBarDelegate)]),
            AllMoviesSection(headerTitle: "", items: discoverMovies.map { AllMoviesCellItem(item: $0, delegate: allMovieDelegate)}),
            MovieCategorySection(items: movieCategoryItems),
            CategorizeMovieSection(headerTitle: "", items: movies.map {
                CategorizeMovieCellItem(item: $0, delegate: allCategorizeMovieDelegate)
            })
        ]
        delegate?.movieHomeViewReloadData()
    }
}
