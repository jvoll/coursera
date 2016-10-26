//
//  WorkoutsFeedItemTableViewCell.swift
//  Workout Manager
//
//  Created by Jason Voll on 2016-10-25.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {


    @IBOutlet weak var workoutName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}