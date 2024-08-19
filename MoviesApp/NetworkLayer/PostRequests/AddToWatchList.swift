//
//  AddToWatchList.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct AddToWatchList: DataRequest {
    
    typealias Response = APIResponse   
    private let accountId = "21323612"
    let sessionId: String
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    var path: String {
        "/3/account/\(accountId)/watchlist"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var queryItems: [String : String] {
        ["session_id": sessionId]
    }
    
    var body: [String : Any]? {
        [
            "media_type": mediaType,
            "media_id": mediaId,
            "watchlist": watchlist
        ]
    }
}
