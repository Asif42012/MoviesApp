//
//  AddToWatchListRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation

struct AddToWatchListRequest: Codable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist
    }
}

