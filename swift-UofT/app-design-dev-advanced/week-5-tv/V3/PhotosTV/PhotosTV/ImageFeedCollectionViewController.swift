//
//  ImageFeedCollectionViewController.swift
//  FirstTV
//
//  Created by Mike Spears on 2016-01-11.
//  Copyright © 2016 YourOganisation. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class ImageFeedCollectionViewController: UICollectionViewController {

    var urlString = "https://api.flickr.com/services/feeds/photos_public.gne?tags=kitten&format=json&nojsoncallback=1"
    
    var feed: Feed?  {
        didSet {
            self.collectionView?.reloadData()
        }
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.feed = nil
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let url = NSURL(string: urlString) {
            appDelegate.loadOrUpdateFeed(url, completion: { (feed) -> Void in
                self.feed = feed
            })
        }
    
    }
    


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.feed?.items.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
    
        let item = self.feed!.items[indexPath.row]

        cell.title.text = item.title
        
        let request = NSURLRequest(URL: item.imageURL)
        
        cell.dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if error == nil && data != nil {
                    let image = UIImage(data: data!)
                    cell.imageView.image = image
                }
            })
            
        }
        
        
        
        cell.dataTask?.resume()
        
        
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? ImageCollectionViewCell {
            cell.dataTask?.cancel()
            cell.imageView.image = nil
        }
    }

}
