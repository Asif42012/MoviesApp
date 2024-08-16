//
//  AuthenticationRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct AuthenticationRequest {
    let requestToken: String
    
    var url: URL? {
        let urlString = "https://www.themoviedb.org/authenticate/\(requestToken)"
        return URL(string: urlString)
    }
}

