//
//  MoviesViewController.swift
//  Rotten Tomatoes
//
//  Created by Carlos Girod on 4/13/15.
//  Copyright (c) 2015 Carlos Girod. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var failureView: UIView!
    
    var movies: [NSDictionary]! = [NSDictionary]()
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.failureView.hidden = true

        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=nxu96vjy2huu9g3vd3kjfd2g")
        var request = NSURLRequest(URL: url!)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data == nil {
                self.tableView.hidden = true
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.failureView.hidden = false
            }else {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.movies = json["movies"] as! [NSDictionary]
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("My Cell", forIndexPath: indexPath) as! MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.titleLabel!.text = movie["title"] as? String
        cell.synopsisLabel!.text = movie["synopsis"] as? String
        
        var url = movie.valueForKeyPath("posters.thumbnail") as? String
        var range = url!.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url = url!.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        cell.pictureView.setImageWithURL(NSURL(string: url!)!)
        
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
        
        var cell = sender as! UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)!
        movieDetailViewController.movie = movies[indexPath.row]
    }

}
