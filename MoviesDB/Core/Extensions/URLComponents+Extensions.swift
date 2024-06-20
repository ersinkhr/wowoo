//
//  URLComponents+Extensions.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation


extension URLComponents {

    init(router: Routable) {
        let url = router.baseURL.appendingPathComponent(router.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!

        guard case let .parameters(parameters) = router.task, router.parametersEncoding == .url else { return }

        queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
    }

}
