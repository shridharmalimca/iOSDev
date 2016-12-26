//
//  ViewController.swift
//  Localization
//
//  Created by Shridhar Mali on 12/26/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerText.text = OK
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

