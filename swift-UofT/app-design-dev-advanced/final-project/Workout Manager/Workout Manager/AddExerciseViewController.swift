//
//  AddExerciseViewController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-29.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit
import CoreData

class AddExerciseViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController!

    var selectedExercise: Exercise?

    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.dataController.managedObjectContext

        let request = NSFetchRequest(entityName: "Exercise")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("tags fetch failed")
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseTableViewCell", forIndexPath: indexPath) as? ExerciseTableViewCell {

            let exercise = fetchedResultsController.objectAtIndexPath(indexPath) as? Exercise
            cell.exerciseName.text = exercise?.name ?? "unnamed :("
            return cell
        }

        print("ERROR: returning default exercise table view cell")
        return ExerciseTableViewCell()
    }

    @IBAction func onCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectedCell = tableView.cellForRowAtIndexPath(indexPath) else {
            print("no selected cell")
            return
        }

        if let _ = selectedCell as? ExerciseTableViewCell {
            selectedExercise = fetchedResultsController.objectAtIndexPath(indexPath) as? Exercise
            performSegueWithIdentifier("unwindToWorkoutDetailsList", sender: self)
        }
    }

}