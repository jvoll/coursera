import Foundation
import UIKit

public enum AvailableFilters: String {
    case RedFilter = "redFilter"
    case GreenFilter = "greenFilter"
    case BlueFilter = "blueFilter"
    case Greyscale = "greyFilter"
    case Brighter = "brightnessfilter"
}

public class ImageProcessor {
    private var defaultFormulas:[AvailableFilters: Formula] = [AvailableFilters: Formula]()

    var originalImage: UIImage
    public init(originalImage: UIImage) {
        self.originalImage = originalImage
        defaultFormulas[AvailableFilters.RedFilter] = RedBump(multiplier: 5)
        defaultFormulas[AvailableFilters.GreenFilter] = GreenBump(multiplier: 5)
        defaultFormulas[AvailableFilters.BlueFilter] = BlueBump(multiplier: 55)
        defaultFormulas[AvailableFilters.Greyscale] = BlackAndWhite()
        defaultFormulas[AvailableFilters.Brighter] = Brightness(bump: 5)
    }

    // Interface to specify the order and parameters for an arbitrary number of filter calculations
    public func applyMultipleFilters(formulas: [Formula]) -> UIImage {
        var image = originalImage
        for formula in formulas {
            image = filterImage(image, formula: formula)
        }
        return image
    }

    // Interface to apply specific default filter/formulas to an image by specifying configuration as a string
    public func applyFilter(filterName: String) -> UIImage {
        var image = originalImage
        switch filterName {
        case AvailableFilters.RedFilter.rawValue:
            image = filterImage(image, formula: defaultFormulas[AvailableFilters.RedFilter]!)
        case AvailableFilters.GreenFilter.rawValue:
            image = filterImage(image, formula: defaultFormulas[AvailableFilters.GreenFilter]!)
        case AvailableFilters.BlueFilter.rawValue:
            image = filterImage(image, formula: defaultFormulas[AvailableFilters.BlueFilter]!)
        case AvailableFilters.Greyscale.rawValue:
            image = filterImage(image, formula: defaultFormulas[AvailableFilters.Greyscale]!)
        case AvailableFilters.Brighter.rawValue:
            image = filterImage(image, formula: defaultFormulas[AvailableFilters.Brighter]!)
        default:
            print("invalid filter name \"\(filterName)\"")
        }
        return image
    }

    private func filterImage(image: UIImage, formula: Formula) -> UIImage {
        let filter = Filter(image: image, formula: formula)
        return filter.apply()
    }
}