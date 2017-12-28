//
//  ReceivingViewController.swift
//  Delegate
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
protocol SendingDataDelegate {
    func sendData(data: String)
}
class ReceivingViewController: UIViewController {
    var delegate: SendingDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension ReceivingViewController: SendingDataDelegate {
    func sendData(data: String) {
        print("Receive data: \(data)")
    }
}
