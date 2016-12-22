//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Shridhar Mali on 12/19/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boxView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        boxView.isUserInteractionEnabled = true
        initializeGestures()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initializeGestures() {
        // TapGuesture 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        boxView.addGestureRecognizer(tapGesture)
        
        //Log Press
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        boxView.addGestureRecognizer(longPress)
        
        //Pinch Gesture
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch))
        boxView.addGestureRecognizer(pinch)
        
        //Rotation 
        let rotation = UIRotationGestureRecognizer(target: self, action:#selector(self.handleRotation))
        boxView.addGestureRecognizer(rotation)
        
        //Pan Gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        boxView.addGestureRecognizer(pan)
    }
    
    
    // MARK: Tap Gesture
    func handleTap(recognizer: UITapGestureRecognizer) {
        print("Tapped")
    }
    
    //MARK: LongPress 
    func handleLongPress(recongnizer: UILongPressGestureRecognizer) {
        print("Long Press called")
    }
    
    //MARK: Pinch
    func handlePinch(recognizer: UIPinchGestureRecognizer) {
        print("Pinch called")
        recognizer.view?.transform = (recognizer.view?.transform.scaledBy(x: recognizer.scale, y: recognizer.scale))!
        recognizer.scale = 1.0
        
    }
    
    //MARK: Rotation
    func handleRotation(recognizer: UIRotationGestureRecognizer) {
        print("Rotation")
        recognizer.view?.transform = (recognizer.view?.transform.rotated(by: 10))!
    }

    func handlePan(recognizer: UIPanGestureRecognizer) {
        print("Pan called")
        let translate = recognizer.translation(in: self.view)
        recognizer.view?.center = CGPoint(x: (recognizer.view?.center.x)! + translate.x, y: (recognizer.view?.center.y)! + translate.y)
        recognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

