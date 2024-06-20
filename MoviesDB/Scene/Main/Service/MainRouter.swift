//
//  MainRouter.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

enum MainRouter {
    case moviesList(pageNr: Int)
}

extension MainRouter: Routable {
    var baseURL: URL {
        URL(string: AppConfiguration.apiBaseURL)!
    }
    
    var path: String {
        switch self {
        case .moviesList:
            "movie/popular"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var task: APIClientTask {
        switch self {
        case .moviesList(let pageNumber):
                .parameters([
                    "page" : pageNumber
                ])
        }
    }
    
    var headers: Headers? {
        defaultHeaders
    }
    
    var parametersEncoding: ParametersEncoding {
        .url
    }
}


