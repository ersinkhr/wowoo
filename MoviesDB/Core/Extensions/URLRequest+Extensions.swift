//
//  URLRequest+Extensions.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

extension URLRequest {

    init(router: Routable) {
        let urlComponents = URLComponents(router: router)

        self.init(url: urlComponents.url!)

        httpMethod = router.method.rawValue
        router.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        if case let .singleArray(arrayContent) = router.task, router.parametersEncoding == .json {
            httpBody = try? JSONSerialization.data(withJSONObject: arrayContent)
        }

        if case let .array(parameters) = router.task, router.parametersEncoding == .json {
            httpBody = try? JSONSerialization.data(withJSONObject: [parameters])
        }

        guard case let .parameters(parameters) = router.task, router.parametersEncoding == .json else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }

}
