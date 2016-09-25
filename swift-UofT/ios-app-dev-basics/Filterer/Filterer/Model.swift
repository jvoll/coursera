//
//  Model.swift
//  Filterer
//
//  Created by Jason Voll on 2016-09-24.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import Foundation
import UIKit

class Model {
    var originalImage = UIImage(named: "yosemite-landscape") {
        didSet {
            currentFilteredImage = originalImage
            imageCache.removeAll(keepCapacity: false)
        }
    }

    var anyFilterApplied: Bool {
        return imageCache.count > 0
    }

    var currentFilteredImage: UIImage?
    var imageCache = [Int: UIImage]()

    init() {
        currentFilteredImage = originalImage
    }

    func apply(formula: Formula) {
        if let cachedImage = imageCache[formula.hashValue] {
            currentFilteredImage = cachedImage
            return
        }

        guard let original = originalImage else {
            print("original image not set")
            return
        }

        let result = FilterUtil.applyFilter(original, formula: formula)
        imageCache[formula.hashValue] = result
        currentFilteredImage = result
    }
}