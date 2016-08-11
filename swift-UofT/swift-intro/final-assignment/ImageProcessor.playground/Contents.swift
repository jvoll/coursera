//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")


// Process the image!
let filter = Filter(image: image!, formula: GreenBump(multiplier: 80))
let filteredImage = filter.apply()
