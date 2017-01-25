//
//  TMDBServicePresenter.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation

class TMDBServicePresenter: TMDBServicePresenterProtocol, TMDBServiceInteractorOutputProtocol
{
    weak var view: TMDBServiceViewProtocol?
    var interactor: TMDBServiceInteractorInputProtocol?
    var wireFrame: TMDBServiceWireFrameProtocol?
    
    init() {}
    
    func fetchMovies(page: Int, keywords: String) {
        view?.showProgress()
        interactor?.fetchMovies(page, keywords: keywords)
    }
    
    func fetchMovies(page: Int, maxYear: String, minYear: String, keywords: String) {
        view?.showProgress()
        interactor?.fetchMovies(page, maxYear: maxYear, minYear: minYear, keywords: keywords)
    }
    
    func onMoviesFetched(moviesData: MoviesData) {
        view?.hideProgress()
        view?.onMoviesFetched(moviesData.total_pages!, page: moviesData.page!, movies: moviesData.results!)
    }
}