//
//  ViewController.swift
//  CustomTableviewCell
//
//  Created by Shridhar Mali on 1/27/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
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
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        switch  indexPath.row {
        case 0:
            cell.cellTextField.placeholder = "First Name"
            cell.lblErrorMsg.text = "Please enter name"
        case 1:
            cell.cellTextField.placeholder = "Middle Name"
            cell.lblErrorMsg.text = "Please enter middle name"
        case 2:
            cell.cellTextField.placeholder = "Last Name"
            cell.lblErrorMsg.text = "Please enter last name"
        case 3:
            cell.cellTextField.placeholder = "Mobile"
            cell.lblErrorMsg.text = "Please enter mobile number"
        case 4:
            cell.cellTextField.placeholder = "Email"
            cell.lblErrorMsg.text = "Please enter email address"
        default:
            cell.cellTextField.placeholder = ""
            cell.lblErrorMsg.text = ""
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

