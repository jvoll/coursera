//
//  ViewController.swift
//  Filterer
//
//  Created by Jason Voll on 2016-09-02.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

//struct RGB {
//    let red: Int
//    let green: Int
//    let blue: Int
//    init(red: Int, green: Int, blue: Int) {
//        self.red = red
//        self.green = green
//        self.blue = blue
//    }
//}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var showingFiltered = false
    let model = Model()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet var secondaryMenu: UIView!

    @IBOutlet weak var filterButton: UIButton!

//    @IBOutlet weak var imageToggle: UIButton!

//    @IBAction func onImageToggle(sender: UIButton) {
//        if imageToggle.selected {
//            imageView.image = originalImage
//        } else {
//            imageView.image = filteredImage
//        }
//        imageToggle.selected = !imageToggle.selected
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false

        imageView.image = model.currentImage

        
//        // Process the image!
//        let myOriginalImage = RGBAImage(image: originalImage)!
//
//        let averages = getAverages(myOriginalImage)
//        let filteredImageRGB = filter(averages, image: myOriginalImage)
//        filteredImage = filteredImageRGB.toUIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func getAverages(image: RGBAImage) -> RGB {
//        var totalRed = 0
//        var totalGreen = 0
//        var totalBlue = 0
//
//        for y in 0..<image.height {
//            for x in 0..<image.width {
//                let pixel = image.pixels[y * image.width + x]
//                totalRed += Int(pixel.red)
//                totalGreen += Int(pixel.green)
//                totalBlue += Int(pixel.blue)
//            }
//        }
//
//        let totalPixels = image.height * image.width
//        return RGB(
//            red: totalRed/totalPixels,
//            green: totalGreen/totalPixels,
//            blue: totalBlue/totalPixels)
//    }
//
//    func filter(averages: RGB, image: RGBAImage) -> RGBAImage{
//        var newImage = image
//        for y in 0..<image.height {
//            for x in 0..<image.width {
//                let index = y * image.width + x
//                var pixel = image.pixels[index]
//                let blueDiff = Int(pixel.blue) - averages.blue
//                if blueDiff > 0 {
//                    pixel.blue = UInt8(max(0, min(255, averages.blue + blueDiff * 5)))
//                    newImage.pixels[index] = pixel
//                }
//            }
//        }
//        return newImage
//    }

    @IBAction func onShare(sender: UIButton) {
        // TODO clean up this force unwrap of image
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }

    @IBAction func onNewPhoto(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))

        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))

        self.presentViewController(actionSheet, animated: true, completion: nil)
    }

    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }

    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        self.presentViewController(cameraPicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }

    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)

        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()

        secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
        }) { completed in
            if completed == true {
                self.secondaryMenu.removeFromSuperview()
            }
        }
    }

    let redBump = RedBump(multiplier: 5)
    @IBAction func onRedFilter(sender: UIButton) {
        model.apply(redBump)
        showFilteredImage()
    }

    let greenBump = GreenBump(multiplier: 5)
    @IBAction func onGreenFilter(sender: UIButton) {
        model.apply(greenBump)
        showFilteredImage()
    }

    let blueBump = BlueBump(multiplier: 5)
    @IBAction func onBlueFilter(sender: UIButton) {
        model.apply(blueBump)
        showFilteredImage()
    }

    let blackAndWhite = BlackAndWhite()
    @IBAction func onBlackAndWhiteFilter(sender: UIButton) {
        model.apply(blackAndWhite)
        showFilteredImage()
    }

    let brightness = Brightness(bump: 10)
    @IBAction func onBrightnessFilter(sender: UIButton) {
        model.apply(brightness)
        showFilteredImage()
    }

    private func showFilteredImage() {
        imageView.image = model.currentImage
        showingFiltered = true
    }

    @IBAction func onCompare(sender: UIButton) {
        if showingFiltered {
            imageView.image = model.originalImage
        } else {
            imageView.image = model.currentImage
        }
        showingFiltered = !showingFiltered
    }
}
