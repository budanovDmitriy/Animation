//
//  ViewController.swift
//  Animation
//
//  Created by Dmitriy Budanov on 14.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Public properties

    var animationCounter = 0
    var countOfBeats = 15
    var beatPerMinute = 90.0
    var duration = 1.0
    let heart = UIImage(named: "heart")
    
    // MARK: - IBOutlets

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        imageContainer.image = heart
    }

    // MARK: - Private methods

    private func beat() {
        UIView.animate(withDuration: duration ,
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                           self.imageHeight.constant += 20
                           self.view.layoutIfNeeded()
            },
                       completion: { [self]_ in
                           self.imageHeight.constant -= 20
                           self.view.layoutIfNeeded()
                           self.animationCounter += 1
                           if (self.animationCounter < countOfBeats ) {
                               self.beat()
            }              else {
                               self.animationCounter = 0
            }
        })
    }
    
    // MARK: - IBActions

    @IBAction func beating(_ sender: UIButton) {
       beat()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        let stepper = sender
        stepper.stepValue = 1
        stepper.maximumValue = 200
        stepper.minimumValue = 60
        label.text = "BPM: " + String(sender.value)
        duration = 60.0 / sender.value
    }
}

