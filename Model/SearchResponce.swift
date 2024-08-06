//
//  SearchMovie.swift
//  MoviesApp
//
//  Created by Asif Hussain on 26/07/2024.
//

import Foundation

// MARK: - Welcome
struct SearchMovieResponce: Codable, Equatable {
    let page: Int
    let results: [MovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

