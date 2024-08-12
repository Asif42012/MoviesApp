//
//  CreateSessionRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 08/08/2024.
//

import Foundation

struct CreateSessionRequest: DataRequest {
    
    typealias Response = CreateSessionResponse
    let requestToken: String
    
    var path: String {
        "/3/authentication/session/new"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var body: [String : Any]? {
        [ "requestToken" : requestToken ]
    }
}
