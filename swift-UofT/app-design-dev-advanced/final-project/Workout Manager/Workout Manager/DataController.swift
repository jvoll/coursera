//
//  DataController.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-25.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import Foundation

class DataController {

    var allExercises = [Exercise]()
    var myWorkouts = [Workout]()

    init() {
        allExercises.append(Exercise(name: "Situps"))
        allExercises.append(Exercise(name: "Pushups"))
        allExercises.append(Exercise(name: "High Plank"))
        allExercises.append(Exercise(name: "Squats"))

        let coreWorkout = Workout(name: "Core workout", sets: 5)
        coreWorkout.exercises.append(allExercises[0])
        coreWorkout.exercises.append(allExercises[2])

        let fullBodyWorkout = Workout(name: "Full Body")
        fullBodyWorkout.exercises.append(allExercises[0])
        fullBodyWorkout.exercises.append(allExercises[1])
        fullBodyWorkout.exercises.append(allExercises[2])
        fullBodyWorkout.exercises.append(allExercises[3])
        fullBodyWorkout.exercises.append(allExercises[2])
        fullBodyWorkout.exercises.append(allExercises[1])
        fullBodyWorkout.exercises.append(allExercises[0])

        myWorkouts.append(coreWorkout)
        myWorkouts.append(fullBodyWorkout)
    }
}