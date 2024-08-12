//
//  MovieCastResponce.swift
//  MoviesApp
//
//  Created by Asif Hussain on 06/08/2024.
//

import Foundation

struct MovieCastResponse: Codable, Equatable {
    let id: Int
    let cast, crew: [Cast]
}
