//
//  ViewController.swift
//  Delegate
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class SendingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func btnClicked(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "receive", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "receive" {
            let view = segue.destination as! ReceivingViewController
            view.delegate = self as? SendingDataDelegate
            view.sendData(data: "Hi")
        }
    }
}

