//
//  WatchListMoviesRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 07/08/2024.
//

import Foundation

struct WatchListMoviesRequest: DataRequest {
    typealias Response = WatchlistResponse
   
    private let accountId = "21323612"
    let sessionId: String
    
    var path: String {
        "/3/account/\(accountId)/watchlist/movies"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String: String] {
        return [
            "session_id": sessionId
        ]
    }
}
