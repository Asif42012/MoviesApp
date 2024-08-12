//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Asif Hussain on 06/08/2024.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response
}

final class DefaultNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response {
        let urlRequest = try request.createURLRequest()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NSError(domain: "Invalid Response", code: 500, userInfo: nil)
        }
        
        return try request.decode(data)
    }
}
