//
//  RequestTokenResponse.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation

struct RequestTokenResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
