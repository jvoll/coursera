import Foundation

// Protocol that all formulas must implement
public protocol Formula {
    func apply(pixel: Pixel, averages: RGB) -> Pixel
}

public class RedBump: Formula {

    let multiplier: Int
    public init(multiplier: Int) {
        self.multiplier = multiplier
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        let redDiff = Int(pixel.red) - averages.red
        if redDiff > 0 {
            var newPixel = pixel
            newPixel.red = UInt8(max(0, min(255, averages.red + redDiff * multiplier)))
            return newPixel
        }
        return pixel
    }
}

public class GreenBump: Formula {

    let multiplier: Int
    public init(multiplier: Int) {
        self.multiplier = multiplier
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        let greenDiff = Int(pixel.green) - averages.green
        if greenDiff > 0 {
            var newPixel = pixel
            newPixel.green = UInt8(max(0, min(255, averages.green + greenDiff * multiplier)))
            return newPixel
        }
        return pixel
    }
}

public class BlueBump: Formula {

    let multiplier: Int
    public init(multiplier: Int) {
        self.multiplier = multiplier
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        let blueDiff = Int(pixel.blue) - averages.blue
        if blueDiff > 0 {
            var newPixel = pixel
            newPixel.blue = UInt8(max(0, min(255, averages.blue + blueDiff * multiplier)))
            return newPixel
        }
        return pixel
    }
}

// No reason to configure the effect of this one, greyscale calls for averaging the 3 pixels
public class BlackAndWhite: Formula {

    public init() {
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        let total = Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)
        let average = total/3
        var newPixel = pixel
        newPixel.red = UInt8(average)
        newPixel.green = UInt8(average)
        newPixel.blue = UInt8(average)
        return newPixel
    }
}

public class Brightness: Formula {

    let bump: Int
    public init(bump: Int) {
        self.bump = bump
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        var newPixel = pixel
        newPixel.red = UInt8(max(0, min(255, Int(pixel.red) + bump)))
        newPixel.green = UInt8(max(0, min(255, Int(pixel.green) + bump)))
        newPixel.blue = UInt8(max(0, min(255, Int(pixel.blue) + bump)))
        return newPixel
    }
}