//
//  FirstViewController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-25.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

class WorkoutsTableViewController: UITableViewController {

    var workouts: [Workout]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutTableViewCell", forIndexPath: indexPath) as! WorkoutTableViewCell

        let workout = self.workouts?[indexPath.row]
        cell.workoutName.text = workout?.name ?? "unnamed :("
//        let item = self.feed!.items[indexPath.row]
//        cell.itemTitle.text = item.title


//
//        let request = NSURLRequest(URL: item.imageURL)
//
//        cell.dataTask = self.urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
//            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                if error == nil && data != nil {
//                    let image = UIImage(data: data!)
//                    cell.itemImageView.image = image
//                }
//            })
//
//        }
//
//
//
//        cell.dataTask?.resume()

        return cell
    }


}

