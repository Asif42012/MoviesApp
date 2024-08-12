//
//  DataRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 06/08/2024.
//

import Foundation

protocol DataRequest {
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String] { get }
    var headers: [String: String] { get }
    var body: [String: Any]? { get }
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension DataRequest {
    
    var baseURL: String {
        "https://api.themoviedb.org"
    }
    
    var path: String {
        ""
    }
    
    var queryItems: [String: String] {
        [:]
    }
    
    var headers: [String: String] {
        [
            "content-type": "application/json",
            "accept": "application/json",
        ]
    }
    
    var body: [String: Any]? {
        nil
    }
    
    var apiKey: String {
        "aeaf72682088a6c3c42cb003b8c0d453"
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        
        var allQueryItems = queryItems
        allQueryItems["api_key"] = apiKey
        
        if !allQueryItems.isEmpty {
            components?.queryItems = allQueryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return components?.url
    }
    
    func createURLRequest() throws -> URLRequest {
        guard let url = url else {
            throw NSError(domain: "Invalid URL", code: 404, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method == .post {
            if let body = body {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                } catch {
                    throw NSError(domain: "Invalid Body", code: 400, userInfo: nil)
                }
            }
        }
        return request
    }
}

