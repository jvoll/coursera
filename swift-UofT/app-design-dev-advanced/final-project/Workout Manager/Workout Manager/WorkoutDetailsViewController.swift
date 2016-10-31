//
//  WorkoutDetailsViewController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-29.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit
import CoreData

class WorkoutDetailsViewController: UITableViewController {

    var workoutName: String?

    var fetchedResultsController: NSFetchedResultsController?

    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.dataController.managedObjectContext

        let request = NSFetchRequest(entityName: "Workout")
        request.predicate = NSPredicate(format: "name == %@", workoutName!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            fatalError("workout details fetch failed")
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let workout = self.fetchedResultsController?.fetchedObjects?[0] as? Workout,
            let numExercises = workout.workoutExercise?.count {
            return numExercises + 1
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let workout = self.fetchedResultsController?.fetchedObjects?[0] as? Workout where
            indexPath.row < workout.numExercises() else {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddExerciseTableViewCell", forIndexPath: indexPath) as! AddExerciseTableViewCell
            return cell
        }

        if let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutDetailTableViewCell", forIndexPath: indexPath) as? WorkoutDetailTableViewCell {



            if let workoutExercises = workout.workoutExercise?.array as? [WorkoutExercise],
                let exercise = workoutExercises[indexPath.row].exercise {
                cell.exerciseName.text = exercise.name ?? "unnamed :("
            } else {
                cell.exerciseName.text = "blah"
            }
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("AddExerciseTableViewCell", forIndexPath: indexPath) as! AddExerciseTableViewCell
        return cell
    }

    @IBAction func unwindToWorkoutDetailsList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddExerciseViewController,
            let exercise = sourceViewController.selectedExercise {

            guard let workout = self.fetchedResultsController?.fetchedObjects?[0] as? Workout else {
                print("ERROR: no workout!")
                return
            }
            let numExercises = workout.workoutExercise?.count ?? 0

            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.dataController.addExercise(exercise, toWorkout: workout)

            let newIndexPath = NSIndexPath(forRow: numExercises, inSection: 0)

            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            tableView.reloadData()
        }
    }
}
