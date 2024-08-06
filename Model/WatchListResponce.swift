//
//  WatchListResponce.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation

struct WatchlistResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
