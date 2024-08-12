//
//  MovieCast.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct MovieCastRequest: DataRequest {
    
    typealias Response = MovieCastResponse
    let id: Int
    
    var path: String {
        "/3/movie/\(id)/credits"
    }
    
    var method: HTTPMethod {
        .get
    }
}

