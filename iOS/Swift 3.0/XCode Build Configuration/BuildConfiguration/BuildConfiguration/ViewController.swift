//
//  ViewController.swift
//  BuildConfiguration
//
//  Created by Shridhar Mali on 2/9/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         print(Configuration.enviornment.serverBaseUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

