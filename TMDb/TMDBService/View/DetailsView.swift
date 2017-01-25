//
//  DetailsView.swift
//  TMDb
//
//  Created by Faris on 1/25/17.
//  Copyright © 2017 360. All rights reserved.
//

import Foundation
import UIKit

class DetailsView: UIViewController {
    
    var movieInfo:Movie?

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var vote: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overview: UITextView!
    @IBOutlet private weak var voteView: UIView!


    override func viewDidLoad() {
        voteView.layer.cornerRadius = 8
        voteView.layer.masksToBounds = true
        
        if let vote_average = movieInfo!.vote_average{
            vote.text  =  "\(vote_average)"
        }
       
        titleLabel.text =  movieInfo?.title
        overview.text   =  movieInfo?.overview
        
        if let poster_path = movieInfo!.backdrop_path{
            let urlStr =  TMDBConfiguration.buildImagePathX3(poster_path)
            image.loadImageFromUrl(urlStr)
        }
    }
}