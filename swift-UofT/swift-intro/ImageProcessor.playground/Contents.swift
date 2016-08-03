//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!
let myOriginalImage = RGBAImage(image: image)!

struct RGB {
    let red: Int
    let green: Int
    let blue: Int
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

func getAverages(image: RGBAImage) -> RGB {
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

func filter(averages: RGB, image: RGBAImage) -> RGBAImage{
    var newImage = image
    for y in 0..<image.height {
        for x in 0..<image.width {
            let index = y * image.width + x
            var pixel = image.pixels[index]
            let blueDiff = Int(pixel.blue) - averages.blue
            if blueDiff > 0 {
                pixel.blue = UInt8(max(0, min(255, averages.blue + blueDiff * 5)))
                newImage.pixels[index] = pixel
            }
        }
    }
    return newImage
}

let averages = getAverages(myOriginalImage)
let filteredImageRGB = filter(averages, image: myOriginalImage)
let filteredImage = filteredImageRGB.toUIImage()

image
