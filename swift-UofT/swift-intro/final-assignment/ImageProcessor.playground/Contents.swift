//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!


let imageProcessor = ImageProcessor(image: image)
var processedImage = imageProcessor.applyFilter(AvailableFilters.BlueFilter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.RedFilter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.Brighter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.GreenFilter.rawValue)

processedImage = imageProcessor.applyFilter(AvailableFilters.Greyscale.rawValue)

// An unknown filter key will result in the image coming back in it's previous state (i.e. no additional filter will be applied)
processedImage = imageProcessor.applyFilter("unknown")
