//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import Foundation

struct MovieDetails: Codable, Equatable {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
// MARK: - Genre
struct Genre: Codable, Equatable {
    let name: String
}

