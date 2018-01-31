//
//  ViewController.swift
//  CustomTableviewCell
//
//  Created by Shridhar Mali on 1/27/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let registrationModel = RegistrationModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrationModel.fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        _ = registrationModel.configureCell()
        cell.cellTextField.placeholder = registrationModel.userInfo[indexPath.row].fieldValue
        if !registrationModel.userInfo[indexPath.row].isValid {
            cell.lblErrorMsg.text = registrationModel.userInfo[indexPath.row].fieldErrorMsg
            cell.lblErrorMsg.textColor = UIColor.red
        } else {
            cell.lblErrorMsg.text = registrationModel.userInfo[indexPath.row].suggesstionMsg
            cell.lblErrorMsg.textColor = UIColor.gray
            cell.lblErrorMsg.font = UIFont(name: "Verdana", size: 10)
        }
        cell.cellTextField.tag = indexPath.row
        cell.cellTextField.addTarget(self, action: #selector(textFieldSelected(_ :)), for: .editingDidBegin)
        return cell
    }
    
    @objc func textFieldSelected(_ sender: UITextField) {
        print(sender.tag)
        switch sender.tag {
        case 0:
            
        default:
            <#code#>
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//extension ViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == registrationModel.
//        return true
//    }
//}

