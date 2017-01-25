//
//  TMDBServiceInteractor.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation
import ObjectMapper

class TMDBServiceInteractor: TMDBServiceInteractorInputProtocol
{
    weak var presenter: TMDBServiceInteractorOutputProtocol?
    var APIDataManager: TMDBServiceAPIDataManagerInputProtocol?
    
    init() {}
    
    func fetchMovies(page: Int, keywords: String) {
        APIDataManager?.discoverMovies(page, keywords: keywords, success: { (json) in
            //print(json)
            let movies = MoviesData(JSONString: json)
            if let data = movies{
                self.presenter?.onMoviesFetched(data)
            }
            }, onError: { (error) in
        })
    }
}