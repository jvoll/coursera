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
        guard let exercises = workout?.exercises else {
            return 1
        }

        if exercises.count > 0 {
            return exercises.count + 1
        }
        return 1
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectedCell = tableView.cellForRowAtIndexPath(indexPath) else {
            print("no selected cell")
            return
        }

        if let workoutDetailCell = selectedCell as? WorkoutDetailTableViewCell {
            
        }

//        if let addExerciseCell = selectedCell as? AddExerciseTableViewCell {
// setup in storyboard, not needed
//        }
    }
}
