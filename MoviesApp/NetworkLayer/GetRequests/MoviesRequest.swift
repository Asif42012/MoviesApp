//
//  MoviesRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 06/08/2024.
//

import Foundation

struct MoviesRequest: DataRequest {
    
    typealias Response = AllMoviesResponse
    let endpoint: EndPoints
    
    var path: String {
        "/3/\(endpoint.rawValue)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
}

