//
//  SessionResponce.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation

struct CreateSessionResponse: Codable {
    let success: Bool
    let sessionId: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
