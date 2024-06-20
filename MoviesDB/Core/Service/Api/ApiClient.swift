//
//  ApiClient.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

final class ApiClient {
    public static let shared = ApiClient()
    
    private let session: URLSession
    
    private init() {
        self.session = .shared
    }
    
    func request<T: Decodable>(responseType: T.Type,
                               router: Routable,
                               completion: @escaping (ApiResponse<T>) -> Void) {
        let request = URLRequest(router: router)
        
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard let self else { return }
            let httpResponse = response as? HTTPURLResponse
            self.handleDataResponse(responseType: responseType,
                                    data: data,
                                    response: httpResponse,
                                    error: error) { result in
                completion(result)
            }
        })
        task.resume()
    }
    
    private func handleDataResponse<T: Decodable>(responseType: T.Type,
                                                  data: Data?,
                                                  response: HTTPURLResponse?,
                                                  error: Error?,
                                                  completion: (ApiResponse<T>) -> Void) {
        guard let response = response else {
            return completion(.failure(.unknown))
        }
        guard let data else {
            return completion(.failure(.unknown))
        }
        
        do {
            let baseResponse = try JSONDecoder().decode(responseType.self, from: data)
            completion(.success(baseResponse))
        } catch(let error) {
            print(error)
            completion(.failure(.decodingError))
        }
        
    }
}
