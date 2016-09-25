//
//  Formulas.swift
//  Filterer
//
//  Created by Jason Voll on 2016-09-24.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import Foundation

import Foundation

// Protocol that all formulas must implement
public protocol Formula {
    var modifier: Int? { get }
    var hashValue: Int { get }
    func apply(pixel: Pixel, averages: RGB) -> Pixel
}

extension Formula {
    public var hashValue: Int {
        get {
            return "\(self.dynamicType)\(modifier)".hashValue
        }
    }
}

public func ==(lhs: RedBump, rhs: RedBump) -> Bool {
    return lhs.modifier == rhs.modifier
}

public func ==(lhs: GreenBump, rhs: GreenBump) -> Bool {
    return lhs.modifier == rhs.modifier
}

public func ==(lhs: BlueBump, rhs: BlueBump) -> Bool {
    return lhs.modifier == rhs.modifier
}

public func ==(lhs: BlackAndWhite, rhs: BlackAndWhite) -> Bool {
    return lhs.modifier == rhs.modifier
}

public func ==(lhs: Brightness, rhs: Brightness) -> Bool {
    return lhs.modifier == rhs.modifier
}

public class RedBump: Formula {

    public var modifier: Int?

    public init(multiplier: Int) {
        self.modifier = multiplier
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        guard let multiplier = self.modifier else {
            return pixel
        }

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

    public var modifier: Int?

    public init(multiplier: Int) {
        self.modifier = multiplier
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        guard let multiplier = self.modifier else {
            return pixel
        }

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

    public var modifier: Int?

    public init(multiplier: Int) {
        self.modifier = multiplier
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        guard let multiplier = self.modifier else {
            return pixel
        }

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

    public var modifier: Int?
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

    public var modifier: Int?

    public init(bump: Int) {
        self.modifier = bump
    }

    public func apply(pixel: Pixel, averages: RGB) -> Pixel {
        guard let bump = self.modifier else {
            return pixel
        }

        var newPixel = pixel
        newPixel.red = UInt8(max(0, min(255, Int(pixel.red) + bump)))
        newPixel.green = UInt8(max(0, min(255, Int(pixel.green) + bump)))
        newPixel.blue = UInt8(max(0, min(255, Int(pixel.blue) + bump)))
        return newPixel
    }
}