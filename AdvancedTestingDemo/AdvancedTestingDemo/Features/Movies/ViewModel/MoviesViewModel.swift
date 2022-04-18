//
//  MoviesViewModel.swift
//  AdvancedTestingDemo
//
//  Created by RishiChaurasia on 18/04/22.
//

import Foundation

protocol MovieViewModelProtocol {
    func getMovieList(with searchString: String) async
    var reloadMovieList: (([Movies]) -> Void)? { get  set}
    var showDataFetchError: ((Error) -> Void)? { get  set}
}

final class MoviesViewModel: MovieViewModelProtocol {
    
    var reloadMovieList: (([Movies]) -> Void)?
    
    var showDataFetchError: ((Error) -> Void)?
    
    var dataFetchError: Error? {
        didSet {
            guard let _dataFetchError = dataFetchError else { return  }
            showDataFetchError?(_dataFetchError)
        }
    }
    
    var moviesArray: [Movies]?
    
    var moviesData = [Movies]() {
        didSet {
            reloadMovieList?(moviesData)
        }
    }
    
    private var newMovieListServiceRequestor: MovieListServiceRequestProtocol
    
    init(newMovieListServiceRequestor: MovieListServiceRequestProtocol) {
        self.newMovieListServiceRequestor = newMovieListServiceRequestor
    }
    
    func getMovieList(with searchString: String) async {
        let requestMapper = MovieRequestMapper.liveDataMovieList(searchString: searchString, apiType: .liveApi)
        await fetchMovieList(with: requestMapper)
    }
    
    func fetchMovieList(with requestMapper: MovieRequestMapper) async {
        
        do {
            let responseData = try await newMovieListServiceRequestor.getMoviesList(apiRequest: requestMapper)
            if let err = responseData.error {
                dataFetchError = err
            } else {
                if let movies = responseData.movieModelArray, movies.count > 0 {
                    moviesArray = movies
                    moviesData = movies
                } else {
                    dataFetchError =  CustomError.dataError
                }
            }
        } catch let serviceError {
            dataFetchError =  serviceError
        }
    }
}
