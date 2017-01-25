//
//  ViewController.swift
//  TMDb
//
//  Created by Faris on 1/24/17.
//  Copyright © 2017 360. All rights reserved.
//

import UIKit

class TMDBMasterView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,  TMDBServiceViewProtocol
{
    var presenter: TMDBServicePresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Movie]()
    
    let cellSpacingHeight = CGFloat(20.0)
    
    // Pagination
    private var isLoading:Bool  = false
    private var pageNumber      = 0
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight  = 193
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.cellIdentifier)
        tableView.backgroundView = UIView()
        self.title = "TMDb"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(filter))

        loadData()
    }
    
    func filter(){
        let popOverVC =  FilterView(nibName: "FilterView", bundle: nil)
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
    }
    
   // MARK:- Pagination
    
    func loadData(){
        if !isLoading {
            pageNumber += 1
            isLoading = true
            getMoreItems(pageNumber)
        }
    }
    
    func getMoreItems(pageNumber:Int) -> () {
        presenter?.fetchMovies(pageNumber, keywords: "")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
           loadData()
        }
    }
    
    // MARK:- TableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MovieCell.cellIdentifier, forIndexPath: indexPath) as! MovieCell
        
        let model = data[indexPath.section]
        cell.configureWithItem(model)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier(AppStoryBoard.SEGUE_NEWS_DETAILS, sender: self)
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "details_segue" {
    //            let detailsView =  segue.destinationViewController as! MoviesDetailsView
    //
    //            if let indexPath = self.tableView.indexPathForSelectedRow {
    //
    //
    //            }
    //        }
    //    }

    // MARK:- TMDBService Delegate Methods

    func showProgress() {
        print("showProgress")
         self.isLoading = true
    }
    
    func hideProgress() {
        print("hideProgress")
         self.isLoading = false
    }
    
    func showMessageDialog(message: String) {
        print("showMessageDialog \(message)")
    }
    
    func onMoviesFetched(totalMovies: Int, page: Int, movies: Array<Movie>) {
        print("onMoviesFetched count \(movies.count)")
        self.pageNumber = page
        insertData(movies)
    }
    
    func insertData(appendMovies:[Movie]) {
        let indexSet = NSIndexSet(indexesInRange: NSMakeRange(tableView.numberOfSections, 20))
        data.appendContentsOf(appendMovies)
        
        tableView.beginUpdates()
        tableView.insertSections(indexSet, withRowAnimation: .Bottom)
        tableView.endUpdates()
        
    }
    
    
    
}