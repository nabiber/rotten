//
//  MovieViewController.swift
//  rottentomatoes
//
//  Created by Nabib El-RAHMAN on 9/16/14.
//  Copyright (c) 2014 Nabib El-RAHMAN. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movie: NSDictionary = NSDictionary();

    @IBOutlet weak var detailOverlay: UITextView!
   
    @IBOutlet weak var largeMovieImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.movie["title"] as String
        self.detailOverlay.backgroundColor = UIColor.clearColor()
        self.detailOverlay.textColor = UIColor.whiteColor()
        self.detailOverlay.editable = false;
        self.detailOverlay.opaque = 50
        self.detailOverlay.text = self.movie["synopsis"] as String
        
        var posters = self.movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        let fixOriginal = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        
        self.largeMovieImage.setImageWithURL(NSURL(string: fixOriginal))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
