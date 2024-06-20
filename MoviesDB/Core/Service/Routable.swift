//
//  Routable.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

typealias Headers = [String: String]

protocol Routable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: APIClientTask { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
    var defaultHeaders: Headers? { get }
}

extension Routable {
    var defaultHeaders: Headers? {
        [
            "Accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YjRiN2U4NTMzNGU2NGI0MDBhNWM5OGJlNzI0YjI4OSIsInN1YiI6IjY2NTQ5NzhmYTJjMzBhYTZhODliODFiOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oLjGkyl7pjiEifZbsyqYBs_XJhlAFBGjpR-0tyVFv9A"
        ]
    }
}
