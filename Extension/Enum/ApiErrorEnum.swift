//
//  ApiErrorEnum.swift
//  MoviesApp
//
//  Created by Asif Hussain on 02/08/2024.
//

import Foundation

enum CustomEror: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
    case invalidSession
    case openURLFailed
    case requestTokenFailed
    case sessionCreationFailed
    case movieAlreadyInWatchlist
}
