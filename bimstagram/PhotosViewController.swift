//
//  PhotosViewController.swift
//  bimstagram
//
//  Created by Bhaskar Maddala on 8/27/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var photos: NSArray = []
    var clientId = "<GET your own key>"
    @IBOutlet weak var photosTableView: UITableView!
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
        self.photosTableView.rowHeight = 320
        self.photosTableView.delegate = self
        self.photosTableView.dataSource = self
        
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.photosTableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func refresh() {
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            self.photos = responseDictionary["data"] as! NSArray
            self.photosTableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoTableViewCell
        let photo = self.photos[indexPath.row] as! NSDictionary
        let caption = photo.valueForKeyPath("caption.text") as? String
        let link = photo.valueForKeyPath("images.low_resolution.url") as? String
        let url = NSURL(string: link!)
        cell.photoImageView.setImageWithURL(url!)
        let alink = photo.valueForKeyPath("caption.from.profile_picture") as? String
        let aurl = NSURL(string: alink!)
        cell.avatarView.setImageWithURL(aurl!)
        let uname = photo.valueForKeyPath("caption.from.username") as? String
        cell.userLabel.text = uname
        return cell
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = photosTableView.indexPathForCell(cell)
        let photo = self.photos[indexPath!.row] as! NSDictionary
        
        let detailViewController = segue.destinationViewController as! PhotoDetailsViewController
        
        detailViewController.photo = photo
    }
}
