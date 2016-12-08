//
//  ViewController.swift
//  ActivityIndicatorView
//
//  Created by Shridhar Mali on 12/8/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startActivity(_ sender: Any) {
        if indicator.isAnimating {
            indicator.stopAnimating()
        }
        indicator.startAnimating()
    }
    
    @IBAction func stopActivity(_ sender: Any) {
        indicator.stopAnimating()
    }
}

