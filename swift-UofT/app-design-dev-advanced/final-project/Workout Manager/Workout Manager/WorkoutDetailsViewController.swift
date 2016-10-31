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
    var workout: Workout? {
        didSet {
            self.title = workout?.name
            tableView.reloadData()
        }
    }

    var fetchedResultsController: NSFetchedResultsController?

    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.dataController.managedObjectContext

        let request = NSFetchRequest(entityName: "Workout")
        request.predicate = NSPredicate(format: "name == %@", workout!.name)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            fatalError("tags fetch failed")
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let path = NSIndexPath(index: 0)
        if let workout = self.fetchedResultsController?.fetchedObjects?[0] as? Workout,
            let numExercises = workout.exercises?.count {
            return numExercises + 1
        }
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < workout?.exercises?.count {
            if let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutDetailTableViewCell", forIndexPath: indexPath) as? WorkoutDetailTableViewCell {

                let workout = self.fetchedResultsController?.fetchedObjects?[0] as? Workout

                if let workoutExercises = workout?.exercises?.allObjects as? [Exercise] {
                    let exercise = workoutExercises[indexPath.row]
                    cell.exerciseName.text = exercise.name ?? "unnamed :("
                } else {
                    cell.exerciseName.text = "blah"
                }
//                let exercise = self.workout?.exercises?.[indexPath.row]
//                cell.exerciseName.text = exercise?.name ?? "unnamed :("
//                cell.exerciseName.text = "blah"
                return cell
            }
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("AddExerciseTableViewCell", forIndexPath: indexPath) as! AddExerciseTableViewCell
        return cell
    }

//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        guard let selectedCell = tableView.cellForRowAtIndexPath(indexPath) else {
//            print("no selected cell")
//            return
//        }
//
//        if let workoutDetailCell = selectedCell as? WorkoutDetailTableViewCell {
//            // TODO allow editing of an exercise (reps, time, etc.)
//        }
//    }

    @IBAction func unwindToWorkoutDetailsList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddExerciseViewController,
            let exercise = sourceViewController.selectedExercise {

            guard let workout = workout else {
                print("ERROR: no workout!")
                return
            }

            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.dataController.addExercise(exercise, toWorkout: workout)

            let nextIndex = workout.numExercises()
            let newIndexPath = NSIndexPath(forRow: nextIndex, inSection: 0)

            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            tableView.reloadData()
        }
    }
}
