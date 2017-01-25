//
//  TMDBConfig.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation

class TMDBConfiguration {
    /*
     * API HOST
     */
    static var API_HOST = "https://api.themoviedb.org"
    
    static var API_VERSION = "3"
    
    /*
     * To build an image URL
     * https://developers.themoviedb.org/3/configuration/get-api-configuration
     */
    static var IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    
    /*
     * API Key (v3 auth)
     */
    static var API_KEY = "d1a73364956004feea730e36d63946e4"
    
    /*
     * API Read Access Token (v4 auth)
     */
    static var READ_ACCESS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMWE3MzM2NDk1NjAwNGZlZWE3MzBlMzZkNjM5NDZlNCIsInN1YiI6IjU4ODdhNzQ4OTI1MTQxNjMwNjAwMWM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.coYxdlgDrv5SOa9TiGMhw2-Mdylq0QOUlsrus4oybH0"
    
     //Example API Request
    ///https://api.themoviedb.org/3/movie/550?api_key=d1a73364956004feea730e36d63946e4

    static var discoverAPIEndPoint = {
        return "\(API_HOST)/\(API_VERSION)/discover/movie?api_key=\(API_KEY)"
    }()
    
    
    static func buildImagePath(poster_path:String)->String{
        return "\(IMAGE_BASE_URL)w500\(poster_path)"
    }
    static func buildImagePathX3(poster_path:String)->String{
        return "\(IMAGE_BASE_URL)w1000\(poster_path)"
    }
    
}