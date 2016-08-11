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

public class Filter {

    let originalImage: UIImage
    let formula: Formula
    var filteredImage: UIImage?

    public init(image: UIImage, formula: Formula) {
        self.originalImage = image
        self.formula = formula
    }

    private func getAverages(image: RGBAImage) -> RGB {
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

    private func filter(averages: RGB, image: RGBAImage) -> RGBAImage{
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

    public func apply() -> UIImage {
        if let filteredImage = filteredImage {
            return filteredImage
        }

        let rgbaOriginal = RGBAImage(image: originalImage)!
        let averages = getAverages(rgbaOriginal)
        let filteredImageRGB = filter(averages, image: rgbaOriginal)
        filteredImage = filteredImageRGB.toUIImage()
        return filteredImage!
    }
}

