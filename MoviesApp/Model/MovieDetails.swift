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
    
    public init(backdropPath: String, genres: [Genre], id: Int, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, runtime: Int, status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.backdropPath = backdropPath
        self.genres = genres
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    init(movieDetails: MovieDetails) {
        self.init(
            backdropPath: movieDetails.backdropPath,
            genres: movieDetails.genres,
            id: movieDetails.id,
            originalTitle: movieDetails.originalTitle,
            overview: movieDetails.overview,
            popularity: movieDetails.popularity,
            posterPath: movieDetails.posterPath,
            releaseDate: movieDetails.releaseDate,
            runtime: movieDetails.runtime,
            status: movieDetails.status,
            tagline: movieDetails.tagline,
            title: movieDetails.title,
            video: movieDetails.video,
            voteAverage: movieDetails.voteAverage,
            voteCount: movieDetails.voteCount
        )
    }
    
    func toMovie() -> Movie {
        return Movie(backdropPath: self.backdropPath,
                     genreIDS: [],
                     id: self.id,
                     originalTitle: self.originalTitle,
                     overview: self.overview,
                     popularity: self.popularity,
                     posterPath: self.posterPath,
                     releaseDate: self.releaseDate,
                     title: self.title,
                     video: self.video,
                     voteAverage: self.voteAverage,
                     voteCount: self.voteCount,
                     runtime: self.runtime
        )
    }
}
// MARK: - Genre
struct Genre: Codable, Equatable {
    let name: String
}
