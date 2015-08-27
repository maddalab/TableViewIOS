//
//  PhotoDetailsViewController.swift
//  bimstagram
//
//  Created by Bhaskar Maddala on 8/27/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    var photo: NSDictionary!
    
    @IBOutlet weak var photoView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let link = photo.valueForKeyPath("images.standard_resolution.url") as? String
        let url = NSURL(string: link!)
        photoView.setImageWithURL(url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
