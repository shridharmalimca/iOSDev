//
//  ViewController.swift
//  RefreshControl
//
//  Created by Shridhar Mali on 12/15/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var refreshControl = UIRefreshControl()
    var counter: Int = 1
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIRefreshControl
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh control title here")
        refreshControl.addTarget(self, action: #selector(self.refreshTableView), for: UIControlEvents.valueChanged)
        tblView.addSubview(refreshControl)
        
        // start timer first time
        startTimer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func startTimer() {
        // schedule timer with timeCounter function
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCounter), userInfo: nil, repeats: true)
        timer.fire()
    }
    func refreshTableView() {
        print("Refresh called")
        // reset counter and start new timer
        counter = 1
        timer.invalidate()
        startTimer()
    }
    func timeCounter() {
        print(counter)
        counter = counter + 1
        if counter >= 10 {
            // stop refreshing and stop timer
            refreshControl.endRefreshing()
            timer.invalidate()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
