//
//  MovieReviewRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct MovieReviewRequest: DataRequest {
    
    typealias Response = ReviewsResponse
    let id: Int
  
    var path: String {
        "/3/movie/\(id)/reviews"
    }

    var method: HTTPMethod {
        .get
    }
}
