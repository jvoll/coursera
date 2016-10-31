//
//  Exercise+CoreDataProperties.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-30.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercise {

    @NSManaged var name: String
    @NSManaged var workouts: NSSet?

}
