//
//  ViewController.swift
//  Filterer
//
//  Created by Jason Voll on 2016-09-02.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {

    let originalImage = UIImage(named: "yosemite-landscape")!
    var filteredImage: UIImage?
    var showingFiltered = false

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageToggle: UIButton!

    @IBAction func onImageToggle(sender: UIButton) {
        if imageToggle.selected {
            imageView.image = originalImage
        } else {
            imageView.image = filteredImage
        }
        imageToggle.selected = !imageToggle.selected
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Process the image!
        let myOriginalImage = RGBAImage(image: originalImage)!

        let averages = getAverages(myOriginalImage)
        let filteredImageRGB = filter(averages, image: myOriginalImage)
        filteredImage = filteredImageRGB.toUIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}

