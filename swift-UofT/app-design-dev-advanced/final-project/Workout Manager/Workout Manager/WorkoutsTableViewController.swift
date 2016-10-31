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
        self.title = "My Workouts"
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
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWorkoutDetails" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                print("no row selected")
                return
            }
            guard let destination = segue.destinationViewController as? WorkoutDetailsViewController else {
                print("destination not WorkoutDetailsViewController")
                return
            }
            guard let workout = self.workouts?[indexPath.row] else {
                print("no workout found")
                return
            }
            destination.workout = workout
        }
    }

//
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        guard let item = self.workouts?[indexPath.row] else {
//            print("Could not find workout for \(indexPath.row)")
//            return
//        }
//
//
//
//        let alertController = UIAlertController(title: "Add Tag", message: "Type your tag", preferredStyle: .Alert)
//        let defaultAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
//            if let tagTitle = alertController.textFields![0].text {
//                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                appDelegate.dataController.tagFeedItem(tagTitle, feedItem: item)
//            }
//
//        }
//        alertController.addAction(defaultAction)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        alertController.addTextFieldWithConfigurationHandler(nil)
//        self.presentViewController(alertController, animated: true, completion: nil)
//
//    }

}
