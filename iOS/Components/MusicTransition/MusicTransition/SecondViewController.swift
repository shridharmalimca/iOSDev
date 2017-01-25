//
//  SecondViewController.swift
//  MusicTransition
//
//  Created by Shridhar Mali on 1/25/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "second View"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.MyApp.miniPlayerStopNotification, object: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


