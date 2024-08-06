//
//  UserReview.swift
//  MoviesApp
//
//  Created by Asif Hussain on 30/07/2024.
//

import Foundation


// MARK: - Welcome
import Foundation

struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content: String
    let createdAt: String
    let id: String
    let updatedAt: String
    let url: String

    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// Structure for author details
struct AuthorDetails: Codable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Int?

    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}
