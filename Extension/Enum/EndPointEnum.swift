//
//  EndPointEnum.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation

enum EndPoints: String{
    case movie = "discover/movie"
    case nowPlaying = "movie/now_playing"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case popular = "movie/popular"
}
