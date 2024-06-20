//
//  APIClientTask.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

public typealias Parameters = [String: Any]

public enum APIClientTask {
    case plain
    case parameters(Parameters)
    case array(Parameters)
    case singleArray([Any])
}
