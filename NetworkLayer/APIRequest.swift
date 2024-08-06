//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Asif Hussain on 24/07/2024.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    //generic funtion for api call//
    func getRequest<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let url = url else {
            completion(.failure(CustomEror.invalidUrl))
            print("Invalid Url in ApiService")
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else{
                print("No data from api Service class")
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomEror.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //generic function for post api
    func postRequest<T: Codable, U: Codable>(
        url: URL?,
        body: T,
        expecting: U.Type,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(CustomEror.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomEror.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
