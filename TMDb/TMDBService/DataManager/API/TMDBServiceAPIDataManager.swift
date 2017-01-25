//
//  TMDBServiceAPIDataManager.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation
import Alamofire

/*
 * TMDBServiceAPIDataManager
 * API Service Level
 */
class TMDBServiceAPIDataManager: TMDBServiceAPIDataManagerInputProtocol
{
    init() {}
    
    func discoverMovies(page: Int, keywords: String, success: (json:String) -> (), onError:(error:String)->()) {
        let url = TMDBConfiguration.discoverAPIEndPoint + "&page=\(page)" + "&primary_release_date.lte=2016" /*+ "&sort_by=primary_release_date.desc"*/
        //print(url)
        HTTPRequest.GET(url, success: { (json) in
            success(json: json)
        }) { (error) in
            onError(error: error)
        }
    }
    
    func discoverMovies(page: Int, keywords: String, minYear: String, maxYear: String, success: (json: String) -> (), onError: (error: String) -> ()) {
        let url = TMDBConfiguration.discoverAPIEndPoint + "&page=\(page)" + "&primary_release_date.gte=\(minYear)" + "&primary_release_date.lte=\(maxYear)" /*+ "&sort_by=primary_release_date.asc"*/
        //print(url)
        HTTPRequest.GET(url, success: { (json) in
            success(json: json)
        }) { (error) in
            onError(error: error)
        }
    }
}

/*
 * HTTPRequest
 * Make http request
 */
private class HTTPRequest{
    class func GET( url:String, success: (json:String) -> (), onError:(error:String)->()){
        //print(url)
        Alamofire.request(.GET, url)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let dictionary):
                    let statusCode = response?.statusCode
                    if statusCode == 200{
                        //print("Success with JSON: \(JSON)")
                        do {
                            let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options:[])
                            let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                            //print(dataString)
                            success(json:dataString as String)
                        } catch {
                            print("JSON serialization failed:  \(error)")
                        }
                        
                    }else{
                        onError(error: "Error while loading data")
                    }
                case .Failure(let data, let error):
                    //print("Request failed with error: \(error)")
                    onError(error: "Request failed with error: \(error)")
                    if let data = data {
                        print("Response data: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                    }
                }
        }
    }
}