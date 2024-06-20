//
//  MainViewModel.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import Foundation

struct MainMoviewCellRepresentationModel {
    var title: String
    var imageUrl: String
}

protocol MainViewModelProtocol {
    var viewDataDidFetch: (() -> Void)? { get set }
    var numberOfItems: Int { get }
    func fetchFavoriteMovies()
    func itemForIndexPath(indexPath: IndexPath) -> MainMoviewCellRepresentationModel
}

final class MainViewModel: MainViewModelProtocol {
    var numberOfItems: Int = 0
    var viewDataDidFetch: (() -> Void)?
    private var cellRepresentationModel: [MainMoviewCellRepresentationModel] = [] {
        didSet {
            numberOfItems = cellRepresentationModel.count
        }
    }
    private let apiService: MainApiService
    private var currentPage: Int = 1
    private var favoriteMovies: MoviesResponseModel?
    
    init(apiService: MainApiService = .init()) {
        self.apiService = apiService
    }
    
    func fetchFavoriteMovies() {
        apiService.getMovies(with: currentPage) { [weak self] response in
            switch response {
            case .success(let movies):
                self?.favoriteMovies = movies
                self?.mapMoviesToCellRepresentation()
                self?.currentPage = movies.page + 1
                self?.viewDataDidFetch?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func itemForIndexPath(indexPath: IndexPath) -> MainMoviewCellRepresentationModel {
        cellRepresentationModel[indexPath.item]
    }
}

private extension MainViewModel {
    func mapMoviesToCellRepresentation(){
        let baseImageUrl = "https://image.tmdb.org/t/p/w200"
        cellRepresentationModel.append(contentsOf:
                                        favoriteMovies?.results.map { res in
            MainMoviewCellRepresentationModel(title: res.title, 
                                              imageUrl: "\(baseImageUrl)\(res.posterPath)")} ?? []
        )
    }
}
