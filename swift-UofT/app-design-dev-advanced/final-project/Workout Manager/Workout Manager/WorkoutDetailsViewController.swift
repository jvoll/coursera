//
//  WorkoutDetailsViewController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-29.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

class WorkoutDetailsViewController: UITableViewController {
    var workout: Workout? {
        didSet {
            self.title = workout?.name
            tableView.reloadData()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let workout = workout else {
            return 1
        }
        return workout.numExercises() + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < workout?.exercises.count {
            if let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutDetailTableViewCell", forIndexPath: indexPath) as? WorkoutDetailTableViewCell {

                let exercise = self.workout?.exercises[indexPath.row]
                cell.exerciseName.text = exercise?.name ?? "unnamed :("
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

            let nextIndex = workout.numExercises()
            let newIndexPath = NSIndexPath(forRow: nextIndex, inSection: 0)
            workout.exercises.append(exercise)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
}
