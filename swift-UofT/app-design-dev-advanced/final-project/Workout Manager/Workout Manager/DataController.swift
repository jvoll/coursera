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
//    var allExercises = [Exercise] {
//        let getExercises = NSFetchRequest(entityName: "Exercise")
//
//        do {
//            return try self.manaageObjectContext.executeFetchRequest(getExercises) as! [Exercise]
//        } catch {
//            fatalError("fetch exercises failed")
//        }
//    }
//
//    var myWorkouts:[Workout] {
//        let getWorkouts = NSFetchRequest(entityName: "Workout")
//
//        do {
//            return try self.managedObjectContext.executeFetchRequest(getWorkouts) as! [Workout]
//        } catch {
//            fatalError("fetch workouts failed")
//        }
//    }

    init(moc: NSManagedObjectContext) {
        self.managedObjectContext = moc
        addDefaultData()
    }

//    init() {
//        allExercises.append(Exercise(name: "Situps"))
//        allExercises.append(Exercise(name: "Pushups"))
//        allExercises.append(Exercise(name: "High Plank"))
//        allExercises.append(Exercise(name: "Squats"))
//
//        let coreWorkout = Workout(name: "Core workout", sets: 5)
//        coreWorkout.exercises.append(allExercises[0])
//        coreWorkout.exercises.append(allExercises[2])
//
//        let fullBodyWorkout = Workout(name: "Full Body")
//        fullBodyWorkout.exercises.append(allExercises[0])
//        fullBodyWorkout.exercises.append(allExercises[1])
//        fullBodyWorkout.exercises.append(allExercises[2])
//        fullBodyWorkout.exercises.append(allExercises[3])
//        fullBodyWorkout.exercises.append(allExercises[2])
//        fullBodyWorkout.exercises.append(allExercises[1])
//        fullBodyWorkout.exercises.append(allExercises[0])
//
//        myWorkouts.append(coreWorkout)
//        myWorkouts.append(fullBodyWorkout)
//    }

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
        if let exercises = workout.exercises {
            let newExercises = NSMutableSet(set: exercises)
            newExercises.addObject(exercise)
            workout.exercises = newExercises
        } else {
            let newExercises = NSMutableSet()
            newExercises.addObject(exercise)
            workout.exercises = newExercises
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
}