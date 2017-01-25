//
//  TMDBServiceWireFrame.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation
import UIKit


class TMDBServiceWireFrame: TMDBServiceWireFrameProtocol
{
    class func presentTMDBServiceModule(fromView window: UIWindow)
    {
        // Generating module components
        let view: TMDBServiceViewProtocol = TMDBMasterView(nibName: "TMDBMasterView", bundle: nil)
        let presenter: protocol<TMDBServicePresenterProtocol, TMDBServiceInteractorOutputProtocol> = TMDBServicePresenter()
        let interactor: TMDBServiceInteractorInputProtocol = TMDBServiceInteractor()
        let APIDataManager: TMDBServiceAPIDataManagerInputProtocol = TMDBServiceAPIDataManager()
        let wireFrame: TMDBServiceWireFrameProtocol = TMDBServiceWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        
        let navController = UINavigationController()
        navController.setViewControllers([view as! TMDBMasterView], animated: true)
        window.rootViewController = navController
    }
    
    class func testTMDBServiceModule(view:TMDBServiceViewProtocol)
    {
        // Generating module components
        let presenter: protocol<TMDBServicePresenterProtocol, TMDBServiceInteractorOutputProtocol> = TMDBServicePresenter()
        let interactor: TMDBServiceInteractorInputProtocol = TMDBServiceInteractor()
        let APIDataManager: TMDBServiceAPIDataManagerInputProtocol = TMDBServiceAPIDataManager()
        let wireFrame: TMDBServiceWireFrameProtocol = TMDBServiceWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
    }
}