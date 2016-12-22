//
//  ViewController.swift
//  ContainerView
//
//  Created by Shridhar Mali on 12/22/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var segmentCtrl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeView(_ sender: Any) {
        if segmentCtrl.selectedSegmentIndex == 0 {
            // ViewA
            UIView.animate(withDuration: 0.5, animations: { 
                self.viewA.alpha = 1.0
                self.viewB.alpha = 0.0
            })
            
        } else {
            // ViewB
            UIView.animate(withDuration: 0.5, animations: {
                self.viewA.alpha = 0.0
                self.viewB.alpha = 1.0
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

