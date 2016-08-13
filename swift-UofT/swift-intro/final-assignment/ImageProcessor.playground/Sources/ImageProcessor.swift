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
    private var formulas:[AvailableFilters: Formula] = [AvailableFilters: Formula]()

    var image: UIImage
    public init(image: UIImage) {
        self.image = image
        formulas[AvailableFilters.RedFilter] = RedBump(multiplier: 5)
        formulas[AvailableFilters.GreenFilter] = GreenBump(multiplier: 5)
        formulas[AvailableFilters.BlueFilter] = BlueBump(multiplier: 5)
        formulas[AvailableFilters.Greyscale] = BlackAndWhite()
        formulas[AvailableFilters.Brighter] = Brightness(bump: 25)
    }

    public func applyFilter(filterName: String) -> UIImage {
        switch filterName {
        case AvailableFilters.RedFilter.rawValue:
            image = filterImage(image, formula: formulas[AvailableFilters.RedFilter]!)
        case AvailableFilters.GreenFilter.rawValue:
            image = filterImage(image, formula: formulas[AvailableFilters.GreenFilter]!)
        case AvailableFilters.BlueFilter.rawValue:
            image = filterImage(image, formula: formulas[AvailableFilters.BlueFilter]!)
        case AvailableFilters.Greyscale.rawValue:
            image = filterImage(image, formula: formulas[AvailableFilters.Greyscale]!)
        case AvailableFilters.Brighter.rawValue:
            image = filterImage(image, formula: formulas[AvailableFilters.Brighter]!)
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