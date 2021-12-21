//
//  ViewController.swift
//  AnimationPractice
//
//  Created by Ankitha Kamath on 20/12/21.
//

import UIKit

class ViewController: UIViewController {

 
 
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var menuTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var button: UIButton!
    @IBAction func button(_ sender: UIButton) {
        button.shake()
    }
    
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet var rectViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var rectViewWidthConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var rectView: UIView!
    @IBOutlet weak var squareView: UIView!
    
    @IBOutlet var squareViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
        let tapFade = UITapGestureRecognizer(target: self, action: #selector (fade))
        let tapSquare = UITapGestureRecognizer(target: self, action: #selector (square))
        let tapRect = UITapGestureRecognizer(target: self, action: #selector (rect))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(long))
           tapGesture.numberOfTapsRequired = 1
          menuButton.addGestureRecognizer(tapGesture)
         menuButton.addGestureRecognizer(longGesture)
        fadeView.addGestureRecognizer(tapFade)
        squareView.addGestureRecognizer(tapSquare)
        rectView.addGestureRecognizer(tapRect)
    }
    @objc func square(){
        squareAnimation()
    }
    @objc func fade(){
        fadeAnimation()
    }
    @objc func rect(){
        rectAnimation()
    }
    @objc func tap() {

        print("Tap happend")
        menuTrailing.constant = -100
        menuButton.transform = .init(rotationAngle: .pi/4)
    }

    @objc func long() {

        print("Long press")
        menuTrailing.constant = 10
        menuButton.transform = .init(rotationAngle: 0)
    }
    
    func fadeAnimation(){
        UIView.transition(with: fadeView, duration: 3, options: .transitionFlipFromRight) {
                   self.fadeView.alpha = 0.1
               } completion: { _ in
                   self.fadeView.alpha = 1
               }
    }
    
    func rectAnimation(){
        UIView.animate(withDuration: 3, delay: 0.05, options: .curveLinear) {
                self.rectViewWidthConstraint.constant = self.view.frame.width
                self.rectViewHeightConstraint.constant = self.view.frame.height
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.rectViewWidthConstraint.constant = 100
                self.rectViewHeightConstraint.constant = 100
               
            }
    }
    
    func squareAnimation(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
                   self.squareViewConstraint.constant = 10
                   self.squareView.transform = .init(rotationAngle: .pi)
                   self.view.layoutIfNeeded()
               } completion: { _ in
                   self.squareViewConstraint.constant = 160
               }
    }
}

extension UIButton {
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.2
        shake.repeatCount = 4
        shake.autoreverses = true
        
        let formPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: formPoint)
        shake.fromValue = fromValue
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.toValue = toValue
        layer.add(shake, forKey: nil)
    }
}
