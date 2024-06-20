//
//  ApiError.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

public enum APIError: Error {
    case unknown
    case decodingError
    
    var errorDescription: String {
        switch self {
        case .unknown:
            "Unknown Error"
        case .decodingError:
            "decoding error"
        }
    }
    
}
