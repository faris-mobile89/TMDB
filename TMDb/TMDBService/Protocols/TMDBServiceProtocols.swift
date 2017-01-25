//
//  TMDBServiceViewProtocol.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation
import UIKit


protocol TMDBServiceViewProtocol: class
{
    var presenter: TMDBServicePresenterProtocol? { get set }
    /**
    * methods for communication PRESENTER -> VIEW
    */
    
    func showProgress()
    func hideProgress()
    func showMessageDialog(message:String)
    func onMoviesFetched(totalMovies:Int, page:Int, movies:Array<Movie>)
}

protocol TMDBServiceWireFrameProtocol: class
{
    static func presentTMDBServiceModule(fromView window: UIWindow)
    /**
    * methods for communication PRESENTER -> WIREFRAME
    */
}

protocol TMDBServicePresenterProtocol: class
{
    var view: TMDBServiceViewProtocol? { get set }
    var interactor: TMDBServiceInteractorInputProtocol? { get set }
    var wireFrame: TMDBServiceWireFrameProtocol? { get set }
    /**
    * methods for communication VIEW -> PRESENTER
    */
    
    func fetchMovies(page:Int, keywords:String)
}

protocol TMDBServiceInteractorOutputProtocol: class
{
    /**
    * methods for communication INTERACTOR -> PRESENTER
    */
    
    func onMoviesFetched(moviesData:MoviesData)
}

protocol TMDBServiceInteractorInputProtocol: class
{
    var presenter: TMDBServiceInteractorOutputProtocol? { get set }
    var APIDataManager: TMDBServiceAPIDataManagerInputProtocol? { get set }
    /**
    * methods for communication PRESENTER -> INTERACTOR
    */
    
    func fetchMovies(page:Int, keywords:String)

}

protocol TMDBServiceDataManagerInputProtocol: class
{
    /**
    * methods for communication INTERACTOR -> DATAMANAGER
    */
    
}

protocol TMDBServiceAPIDataManagerInputProtocol: class
{
    /**
    * methods for communication INTERACTOR -> APIDATAMANAGER
    */
    //primary_release_date.gte
    func discoverMovies(page:Int, keywords:String, success: (json:String) -> (), onError:(error:String)->())
    func discoverMovies(page: Int, keywords: String, minYear: Int, maxYear: Int, success: (json:String) -> (), onError:(error:String)->())
}
