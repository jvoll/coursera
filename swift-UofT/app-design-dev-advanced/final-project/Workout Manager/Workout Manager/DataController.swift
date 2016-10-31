//
//  DataController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-25.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import Foundation
import CoreData

class DataController {

    let managedObjectContext: NSManagedObjectContext

    init(moc: NSManagedObjectContext) {
        self.managedObjectContext = moc
        addDefaultData()
    }

    convenience init?() {

        guard let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd") else {
            return nil
        }

        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            return nil
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc

        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("Workouts.sqlite")

        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store.")
        }

        self.init(moc: moc)
    }

    func addDefaultData() {
        createWorkout("Core", sets: 3)
        createWorkout("Full Body")

        createExercise("Situps")
        createExercise("Pushups")
        createExercise("High plank")
        createExercise("Low plank")
        createExercise("Squats")
    }

    func createExercise(name: String) {
        let checkExists = NSFetchRequest(entityName: "Exercise")
        checkExists.predicate = NSPredicate(format: "name == %@", name)

        var fetchedExercises: [Exercise]!
        do {
            fetchedExercises = try self.managedObjectContext.executeFetchRequest(checkExists) as! [Exercise]
        } catch {
            fatalError("fetch failed")
        }

        if fetchedExercises.count > 0 {
            print("no duplicate exercises allowed")
            return
        }

        if let insertedExercise = NSEntityDescription.insertNewObjectForEntityForName("Exercise", inManagedObjectContext: self.managedObjectContext) as? Exercise {
            insertedExercise.name = name
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }

    func createWorkout(name: String, sets: Int = 1) {
        let checkExists = NSFetchRequest(entityName: "Workout")
        checkExists.predicate = NSPredicate(format: "name == %@", name)

        var fetchedWorkouts: [Workout]!
        do {
            fetchedWorkouts = try self.managedObjectContext.executeFetchRequest(checkExists) as! [Workout]
        } catch {
            fatalError("fetch failed")
        }

        if fetchedWorkouts.count > 0 {
            print("no duplicate workouts allowed")
            return
        }

        if let insertedWorkout = NSEntityDescription.insertNewObjectForEntityForName("Workout", inManagedObjectContext: self.managedObjectContext) as? Workout {
            insertedWorkout.name = name
            insertedWorkout.sets = sets
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }

    func addExercise(exercise: Exercise, toWorkout workout: Workout) {
        if workout.workoutExercise == nil {
            workout.workoutExercise = NSMutableOrderedSet()
        }

        if let workoutExercise = NSEntityDescription.insertNewObjectForEntityForName("WorkoutExercise", inManagedObjectContext: self.managedObjectContext) as? WorkoutExercise {
            workoutExercise.exercise = exercise
            workoutExercise.workout = workout
            workout.workoutExercise?.addObject(workoutExercise)
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
}