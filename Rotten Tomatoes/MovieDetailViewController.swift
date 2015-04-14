//
//  MovieDetailViewController.swift
//  Rotten Tomatoes
//
//  Created by Carlos Girod on 4/13/15.
//  Copyright (c) 2015 Carlos Girod. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelView.hidden = true

        titleLabel!.text = movie["title"] as? String
        synopsisLabel!.text = movie["synopsis"] as? String
        
        var url = movie.valueForKeyPath("posters.thumbnail") as? String
        var range = url!.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            url = url!.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        pictureView.setImageWithURL(NSURL(string: url!)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouch(sender: AnyObject) {
        if (self.labelView.hidden) {
            self.labelView.hidden = false
        }else {
            self.labelView.hidden = true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
