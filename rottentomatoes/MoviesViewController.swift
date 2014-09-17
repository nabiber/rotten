//
//  MoviesViewController.swift
//  rottentomatoes
//
//  Created by Nabib El-RAHMAN on 9/14/14.
//  Copyright (c) 2014 Nabib El-RAHMAN. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary] = []
    var refreshControl:UIRefreshControl!  // An optional variable

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: Selector("refreshInvoked"), forControlEvents: UIControlEvents.ValueChanged)
       // self.tableView.addSubview(refreshControl)
        
        loadMovies()
     
    }
    
    func refreshInvoked() {
        print("REFRESH")
        loadMovies(viaPullToRefresh: true)
    }
    
    
    func loadMovies(viaPullToRefresh: Bool = false)
    {
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6d67dgzvjjr45c45z94h3hhn&limit=20&country=US"
        
        var request = NSURLRequest(URL: NSURL(string: url))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {  (response, data, err) -> Void in
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                
                
                self.movies = object["movies"] as [NSDictionary]
                
                
                self.tableView.reloadData()
                if (viaPullToRefresh) {
                    self.refreshControl.endRefreshing()
                }
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = (tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell)
        
        var movie = movies[indexPath.row]
        
     
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        let fixOriginal = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "det")
        
        cell.posterView.setImageWithURL(NSURL(string: fixOriginal))
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var movieController = segue.destinationViewController as MovieViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow()
        var movie = self.movies[indexPath.row]
        
        movieController.movie = movie

    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
