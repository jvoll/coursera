//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Create image processor with original image
let imageProcessor = ImageProcessor(originalImage: image)

// Test out the interface to provide an arbitrary number of filters and configure them
var formulas: [Formula] = [
    RedBump(multiplier: 5),
    Brightness(bump: 5),
    BlueBump(multiplier: 14)
]
var processedImage = imageProcessor.applyMultipleFilters(formulas)

// Process the image using each of the default filter configurations
processedImage = imageProcessor.applyFilter(AvailableFilters.BlueFilter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.RedFilter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.Brighter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.GreenFilter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.Greyscale.rawValue)

// An unknown filter key will result in the image coming back in it's original state (i.e. no filter will be applied)
processedImage = imageProcessor.applyFilter("unknown")
