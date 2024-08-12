//
//  MovieResponce.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation


struct AllMoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    enum CodingKeys: String, CodingKey {
        case page, results
    }
}
