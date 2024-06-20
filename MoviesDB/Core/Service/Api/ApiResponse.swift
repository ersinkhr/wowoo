//
//  ApiResponse.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

public enum ApiResponse<T: Decodable> {
    case success(T)
    case failure(APIError)
}
