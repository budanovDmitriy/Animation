//
//  AnimationController.swift
//  Animation
//
//  Created by Dmitriy Budanov on 15.03.2022.
//

import UIKit

class AnimationController: UIViewController {
    
    // MARK: - Public properties
    
    var roundRadius:CGFloat = 25
    var viewHeight:CGFloat = 0
    var viewWidth:CGFloat = 0
    var durationForHeight = 0.0
    var speed = 10.0
    var duration = 4.0
    
    // MARK: - IBOutlets

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var roundWidth: NSLayoutConstraint!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRound()
    }
    
    // MARK: - Private methods

    private func setupRound() {
        roundWidth.constant = roundRadius * 2
        roundView.layer.cornerRadius = roundRadius
        roundView.backgroundColor = .cyan
        viewHeight = self.view.bounds.height
        viewWidth = self.view.bounds.width
        durationForHeight = viewHeight / viewWidth
    }
    
    private func toBottom() {
        UIView.animate(withDuration: (duration * durationForHeight / speed),
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                           self.top.constant += (self.viewHeight - self.roundRadius * 2 - 40)
                           self.view.layoutIfNeeded()
        },
                       completion: {_ in
                           self.toTrailing()
        })
    }
    private func toTrailing() {
        UIView.animate(withDuration: (duration / speed),
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                            self.leading.constant += (self.viewWidth - self.roundRadius * 2)
                            self.view.layoutIfNeeded()
        },
                       completion: {_ in
                           self.toTop()
        })
    }
    private func toTop() {
        UIView.animate(withDuration: (duration * durationForHeight / speed),
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                           self.top.constant -= (self.viewHeight - self.roundRadius * 2 - 40)
                           self.view.layoutIfNeeded()
        },
                       completion: {_ in
                           self.toLeading()
        })
    }
    private func toLeading(){
        UIView.animate(withDuration: (duration / speed),
                       delay: 0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                           self.leading.constant -= (self.viewWidth - self.roundRadius * 2)
                           self.view.layoutIfNeeded()
        },
                       completion: {_ in
                           self.toBottom()
        })
    }
    
    // MARK: - IBActions
    
    @IBAction func action(_ sender: Any) {
        toBottom()
    }
    
}
