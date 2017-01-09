//
//  ViewController.swift
//  Notification
//
//  Created by Shridhar Mali on 1/9/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func scheduleNotification(_ sender: Any) {
        
        let localNotification = UILocalNotification()
        localNotification.alertBody = "Hi This is notification"
        localNotification.fireDate = Date(timeIntervalSinceNow: 5)
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.category = "localNotification"
        UIApplication.shared.scheduleLocalNotification(localNotification)
        
    }


}

