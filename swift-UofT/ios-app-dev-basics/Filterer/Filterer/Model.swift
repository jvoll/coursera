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
            currentImage = originalImage
            imageCache.removeAll(keepCapacity: false)
        }
    }

    var currentImage: UIImage?
    var imageCache = [Int: UIImage]()

    init() {
        currentImage = originalImage
    }

    func apply(formula: Formula) {
        if let cachedImage = imageCache[formula.hashValue] {
            currentImage = cachedImage
            return
        }

        guard let original = originalImage else {
            print("original image not set")
            return
        }

        let result = FilterUtil.applyFilter(original, formula: formula)
        imageCache[formula.hashValue] = result
        currentImage = result
    }
}