//
//  Workout.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-25.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import Foundation

class Workout {
    var name: String
    var sets: Int
    var exercises = [Exercise]()

    init(name: String, sets: Int = 1) {
        self.name = name
        self.sets = sets
    }
}