//
//  AuthService.swift
//  MoviesApp
//
//  Created by Asif Hussain on 15/08/2024.
//

import Foundation
import UIKit

protocol MovieAuthService {
    func createRequestToken() async throws -> RequestTokenResponse
    func createSession(requestToken: String) async throws -> CreateSessionResponse
    func authenticateRequestToken(requestToken: String)
    func getSessionId() async throws -> String
}

final class DefaultAuthService: MovieAuthService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func createRequestToken() async throws -> RequestTokenResponse {
        let request = CreateTokenRequest()
        let response = try await networkService.request(request)
        return response
    }
    
    func createSession(requestToken: String) async throws -> CreateSessionResponse {
        let request = CreateSessionRequest(requestToken: requestToken)
        let response = try await networkService.request(request)
        UserDefaults.standard.set(response.sessionId, forKey: "SessionID")
        return response
    }
    
    func authenticateRequestToken(requestToken: String) {
        let request = AuthenticationRequest(requestToken: requestToken)
        guard let url = request.url else {
            print("Invalid URL")
            return
        }
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
    
    func getSessionId() async throws -> String {
        if let sessionId = UserDefaults.standard.string(forKey: "SessionID") {
            return sessionId
        } else {
            do {
                let requestToken = try await createRequestToken()
                authenticateRequestToken(requestToken: requestToken.requestToken)
                
                try await Task.sleep(nanoseconds: 30 * 1_000_000_000) // 30 seconds
                let sessionId = try await createSession(requestToken: requestToken.requestToken)
                return sessionId.sessionId
            } catch {
                throw error
            }
        }
    }
}
