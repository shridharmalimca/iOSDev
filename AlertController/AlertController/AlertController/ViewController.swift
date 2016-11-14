//
//  ViewController.swift
//  AlertController
//
//  Created by Shridhar Mali on 11/14/16.
//  Copyright © 2016 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func simpleAlert(_ sender: Any) {
        let alertController = UIAlertController(title:"", message: "This is simple alert", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func alertWithTitle(_ sender: Any) {
        let alertController = UIAlertController(title:"Alert Title", message: "This is simple alert", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func alertWithTwoButtons(_ sender: Any) {
        let alertController = UIAlertController(title:"Alert Title", message: "This is simple alert", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

