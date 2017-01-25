//
//  TMDbTests.swift
//  TMDbTests
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import XCTest
@testable import TMDb

class TMDbTests: XCTestCase, TMDBServiceViewProtocol {
    
    var presenter: TMDBServicePresenterProtocol?
    var finished = false
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        TMDBServiceWireFrame.testTMDBServiceModule(self)
        

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        print("tearDown()")
    }
    
    func testFetchData(){
        presenter?.fetchMovies(0, keywords: "")
        
        // Wait for the async request to complete
        while !finished {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
        }
    }
    
    // MARK:- TMDBService Delegate Methods
    
    func showProgress() {
        print("showProgress")
    }
    
    func hideProgress() {
        print("hideProgress")
    }
    
    func showMessageDialog(message: String) {
        print("showMessageDialog \(message)")
    }
    
    func onMoviesFetched(totalMovies: Int, page: Int, movies: Array<Movie>) {
        finished = true
        
        XCTAssertNotNil(movies, "movies should not be nil")
        
        XCTAssertNotNil(totalMovies, "totalMovies should not be nil")
        
        XCTAssertNotNil(page, "page should not be nil")
        
        print("onMoviesFetched count \(movies.count)")
        
    }
}
