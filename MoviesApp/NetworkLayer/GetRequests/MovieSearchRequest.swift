//
//  MovieSearchRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 07/08/2024.
//

import Foundation

struct MovieSearchRequest: DataRequest {
    
    typealias Response = SearchMovieResponse
    let query: String
  
    var path: String {
        "/3/search/movie"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [String: String] {
        [
            "query": query,
        ]
    }
}

