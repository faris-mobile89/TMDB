//
//  MovieCell.swift
//  TMDb
//
//  Created by Faris Abu Saleem on 1/25/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieCell:UITableViewCell{
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var labelReleaseDate: UILabel!

    @IBOutlet private weak var cellImageView: UIImageView!
    
    class var cellIdentifier: (String) {
        return "MovieCell"
    }
    
    func configureWithItem(item: Movie) -> () {
        
        selectionStyle = .None
        
        if let title = item.title
        {
            label.text  = title
        }else
        {
            label.text = ""
        }
        
        if let date = item.release_date
        {
            labelReleaseDate.text  = "Release date: " + date
        }
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor =  UIColor.whiteColor()
        layer.borderColor = UIColor(red:239, green:239, blue: 239,alpha: 1).CGColor
        layer.borderWidth = 0.5
        
        if let poster_path = item.backdrop_path{
            let urlStr =  TMDBConfiguration.buildImagePath(poster_path)
            cellImageView.loadImageFromUrl(urlStr)
        }
    }
}


extension UIImageView{
    
    func loadImageFromUrl(url:String){
        let myCache = ImageCache(name: "TMDbCache")
        
        guard let urlString = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet()) else {
            print("loadImageFromUrl: Invalid Url: \(url)")
            return
        }
        
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        self.kf_setImageWithURL(url,
                                placeholderImage: nil,
                                optionsInfo: [.TargetCache(myCache)])
    }
    
}