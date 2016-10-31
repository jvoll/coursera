//
//  FirstViewController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-25.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit
import CoreData

class WorkoutsTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController!

    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.dataController.managedObjectContext

        let request = NSFetchRequest(entityName: "Workout")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("tags fetch failed")
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
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutTableViewCell", forIndexPath: indexPath) as! WorkoutTableViewCell

        let workout = self.fetchedResultsController.objectAtIndexPath(indexPath) as? Workout
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

            let fetchedWorkout = self.fetchedResultsController.objectAtIndexPath(indexPath) as? Workout
            guard let workout = fetchedWorkout else {
                print("no workout found")
                return
            }
            destination.workoutName = workout.name
        }
    }
}

