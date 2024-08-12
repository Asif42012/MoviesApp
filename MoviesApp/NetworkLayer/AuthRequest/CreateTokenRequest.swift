//
//  CreateTokenRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct CreateTokenRequest: DataRequest{
  
    typealias Response = RequestTokenResponse
    
    var path: String {
        "/3/authentication/token/new"
    }
    
    var method: HTTPMethod {
        .get
    }
}
