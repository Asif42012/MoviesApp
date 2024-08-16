//
//  RateMovieRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct RateMovieRequest: DataRequest {
    
    typealias Response = APIResponse
    let id: Int
    let sessionId: String
    let rating: Double
    
    var path: String {
        "/3/movie/\(id)/rating"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var queryItems: [String : String] {
        [
            "session_id": sessionId
        ]
    }
    
    var body: [String : Any]? {
        [
            "value": rating
        ]
    }
}
