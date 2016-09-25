//
//  FilterUtil.swift
//  Filterer
//
//  Created by Jason Voll on 2016-09-24.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import Foundation

import Foundation
import UIKit

public struct RGB {
    let red: Int
    let green: Int
    let blue: Int
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

public class FilterUtil {

    private static func getAverages(image: RGBAImage) -> RGB {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0

        for y in 0..<image.height {
            for x in 0..<image.width {
                let pixel = image.pixels[y * image.width + x]
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }

        let totalPixels = image.height * image.width
        return RGB(
            red: totalRed/totalPixels,
            green: totalGreen/totalPixels,
            blue: totalBlue/totalPixels)
    }

    private static func filter(averages: RGB, image: RGBAImage, formula: Formula) -> RGBAImage{
        var newImage = image
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y * image.width + x
                let pixel = image.pixels[index]
                newImage.pixels[index] = formula.apply(pixel, averages: averages)
            }
        }
        return newImage
    }

    public static func applyFilter(image: UIImage, formula: Formula) -> UIImage {
        // TODO log error and show message on fail?
        let rgbaOriginal = RGBAImage(image: image)!
        let averages = getAverages(rgbaOriginal)
        let filteredImageRGB = filter(averages, image: rgbaOriginal, formula: formula)
        // TODO log error and show message on fail?
        return filteredImageRGB.toUIImage()!
    }
}

