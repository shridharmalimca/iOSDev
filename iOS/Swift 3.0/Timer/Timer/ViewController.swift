//
//  ViewController.swift
//  Timer
//
//  Created by Shridhar Mali on 9/4/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameTimer: Timer!
    var counter: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func runTimedCode() {
        counter = counter + 1
        print(counter)
    }

}

