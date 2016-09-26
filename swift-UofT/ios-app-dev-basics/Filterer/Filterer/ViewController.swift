//
//  ViewController.swift
//  Filterer
//
//  Created by Jason Voll on 2016-09-02.
//  Copyright © 2016 Jason Learning Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var showingFiltered = false
    let model = Model()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var editFilterView: UIView!
    @IBOutlet weak var editSlider: UISlider!

    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var originalTextView: UITextView!

    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blackWhiteButton: UIButton!
    @IBOutlet weak var brightnessButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup filter menu (secondaryMenu)
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        redButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        greenButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        blueButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        blackWhiteButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        brightnessButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit

        // Setup edit filter menu (editFilterView)
        editFilterView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        editFilterView.translatesAutoresizingMaskIntoConstraints = false
        editSlider.continuous = false

        reset()

        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageTappedHandler(_:)))
        gestureRecognizer.minimumPressDuration = 0.01
        imageView.addGestureRecognizer(gestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imageTappedHandler(sender: UITapGestureRecognizer) {
        if sender.state == .Began {
            toggleShowingImage()
        } else if sender.state == .Ended{
            toggleShowingImage()
        }
    }

    private func reset() {
        imageView.image = model.currentFilteredImage
        compareButton.enabled = false
        editButton.enabled = false
        self.originalTextView.alpha = 0.7
    }

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
            model.originalImage = image
            reset()
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onFilter(sender: UIButton) {
        editButton.selected = false
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            hideEditMenu()
            showSecondaryMenu()
            sender.selected = true
        }
    }

    @IBAction func onEdit(sender: UIButton) {
        filterButton.selected = false
        if (sender.selected) {
            sender.selected = false
            hideEditMenu()
        } else {
            sender.selected = true
            hideSecondaryMenu()
            showEditMenu()
        }
    }

    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)

        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(55)
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

    func showEditMenu() {
        guard let formula = currentFormula,
            let modifier = formula.modifier,
            let minValue = formula.minValue,
            let maxValue = formula.maxValue else {
            print("Error: no current formula/modifier")
            return
        }
        editSlider.minimumValue = minValue
        editSlider.maximumValue = maxValue
        editSlider.value = Float(modifier)

        view.addSubview(editFilterView)

        let bottomConstraint = editFilterView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = editFilterView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = editFilterView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = editFilterView.heightAnchor.constraintEqualToConstant(55)
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()

        UIView.animateWithDuration(0.4) {
            self.editFilterView.alpha = 1.0
        }
    }

    func hideEditMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.editFilterView.alpha = 0
        }) { completed in
            if completed == true {
                self.editFilterView.removeFromSuperview()
            }
        }
    }

    @IBAction func onSliderChanged(sender: UISlider) {
        guard var formula = currentFormula else {
            print("Error: no current formula")
            return
        }

        let value = sender.value
        formula.modifier = Int(value)
        model.apply(formula)
        showFilteredImage()
    }

    var currentFormula: Formula?
    let redBump = RedBump(multiplier: 5)
    @IBAction func onRedFilter(sender: UIButton) {
        currentFormula = redBump
        model.apply(redBump)
        showFilteredImage()
        editButton.enabled = true
    }

    let greenBump = GreenBump(multiplier: 5)
    @IBAction func onGreenFilter(sender: UIButton) {
        currentFormula = greenBump
        model.apply(greenBump)
        showFilteredImage()
        editButton.enabled = true
    }

    let blueBump = BlueBump(multiplier: 5)
    @IBAction func onBlueFilter(sender: UIButton) {
        currentFormula = blueBump
        model.apply(blueBump)
        showFilteredImage()
        editButton.enabled = true
    }

    let blackAndWhite = BlackAndWhite()
    @IBAction func onBlackAndWhiteFilter(sender: UIButton) {
        currentFormula = blackAndWhite
        model.apply(blackAndWhite)
        showFilteredImage()
        editButton.enabled = false
    }

    let brightness = Brightness(bump: 50)
    @IBAction func onBrightnessFilter(sender: UIButton) {
        currentFormula = brightness
        model.apply(brightness)
        showFilteredImage()
        editButton.enabled = true
    }

    private func showFilteredImage() {
        UIView.transitionWithView(self.imageView,
                                  duration:0.5,
                                  options: UIViewAnimationOptions.TransitionCrossDissolve,
                                  animations: {
                                    self.imageView.image = self.model.currentFilteredImage
                                    self.originalTextView.alpha = 0
                                    },
                                  completion: nil)
        showingFiltered = true
        compareButton.enabled = true
    }

    private func showOriginal() {
        UIView.transitionWithView(self.imageView,
                                  duration:0.5,
                                  options: UIViewAnimationOptions.TransitionCrossDissolve,
                                  animations: {
                                    self.imageView.image = self.model.originalImage
                                    self.originalTextView.alpha = 0.7
                                    },
                                  completion: nil)
        showingFiltered = false
    }

    @IBAction func onCompare(sender: UIButton) {
        guard let formula = currentFormula else {
            print("Error: current formula not specified")
            return
        }

        toggleShowingImage()

        if showingFiltered && formula.modifiable {
            editButton.enabled = true
        } else {
            hideEditMenu()
            editButton.selected = false
            editButton.enabled = false
        }
    }

    func toggleShowingImage() {
        if !model.anyFilterApplied {
            return
        }

        if showingFiltered {
            showOriginal()
        } else {
            showFilteredImage()
        }
    }
}
