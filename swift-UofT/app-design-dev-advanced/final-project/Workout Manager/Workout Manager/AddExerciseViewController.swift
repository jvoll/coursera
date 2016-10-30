//
//  AddExerciseViewController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-29.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

class AddExerciseViewController: UITableViewController {

    var availableExercises: [Exercise]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            print("ERROR: app delegate non-existent?!")
            return
        }

        availableExercises = appDelegate.dataController.allExercises
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let availableExercises = availableExercises else {
            return 0
        }

        return availableExercises.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseTableViewCell", forIndexPath: indexPath) as? ExerciseTableViewCell {

            let exercise = self.availableExercises?[indexPath.row]
            cell.exerciseName.text = exercise?.name ?? "unnamed :("
            return cell
        }

        print("ERROR: returning default exercise table view cell")
        return ExerciseTableViewCell()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        <#code#>
    }


    @IBAction func onCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        guard let selectedCell = tableView.cellForRowAtIndexPath(indexPath) else {
//            print("no selected cell")
//            return
//        }
//
//        if let workoutDetailCell = selectedCell as? WorkoutDetailTableViewCell {
//
//        }
//
//        if let addExerciseCell = selectedCell as? AddExerciseTableViewCell {
//            
//        }
//    }

}