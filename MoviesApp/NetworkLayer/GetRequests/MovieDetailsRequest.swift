//
//  MovieDetailsRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 07/08/2024.
//

import Foundation

struct MovieDetailsRequest: DataRequest {
    
    typealias Response = MovieDetails
    let movieId: Int
    
    var path: String {
        "/3/movie/\(movieId)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
}
