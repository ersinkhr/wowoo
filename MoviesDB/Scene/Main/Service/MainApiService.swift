//
//  MainApiService.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

final class MainApiService {
    private let router = MainRouter.self
    
    public func getMovies(with pageId: Int, completion: @escaping (ApiResponse<MoviesResponseModel>) -> Void) {
        ApiClient.shared.request(responseType: MoviesResponseModel.self,
                                 router: router.moviesList(pageNr: pageId),
                                 completion: completion)
    }

}
