//
//  ViewController.swift
//  FormValidation
//
//  Created by Shridhar Mali on 1/27/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
// REFER this link https://cocoacasts.com/five-simple-tips-to-make-user-friendly-forms-on-ios

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var firstNameErrorLbl: UILabel!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordtxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    
    @IBOutlet weak var lastNameErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var confirmPasswordErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var mobileErrorLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.firstNameErrorLbl.isHidden = true
        lastNameErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        confirmPasswordErrorLbl.isHidden = true
        emailErrorLbl.isHidden = true
        mobileErrorLbl.isHidden = true
        firstNameTxt.placeholder = "First Name"
        lastNameTxt.placeholder = "Last Name"
        passwordTxt.placeholder = "Password"
        confirmPasswordtxt.placeholder = "Confirm Password"
        emailTxt.placeholder = "Email"
        mobileTxt.placeholder = "Mobile"
    }

    func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        if textField == firstNameTxt {
            return (text.count > 6 || text.count < 0 , "Please enter valid name")
        }
        
        if textField == lastNameTxt {
            return (text.count > 6 || text.count < 0 , "Please enter valid last name")
        }
        
        if textField == passwordTxt {
            return (text.count > 3 || text.count < 0, "Please enter valid password")
        }
        
        return (text.count == 0, "All fields are mandatory")
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let (valid, message) = validate(textField)
        switch textField {
        case firstNameTxt:
            if valid {
                lastNameTxt.becomeFirstResponder()
            }
            self.firstNameErrorLbl.text = message
            self.firstNameErrorLbl.textColor = UIColor.red
            // Show/Hide Password Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.firstNameErrorLbl.isHidden = valid
            })
        case lastNameTxt:
            if valid {
                passwordTxt.becomeFirstResponder()
            }
            self.lastNameErrorLbl.text = message
            self.lastNameErrorLbl.textColor = UIColor.red
            UIView.animate(withDuration: 0.25, animations: {
                self.lastNameErrorLbl.isHidden = valid
            })
            
        case passwordTxt:
            if valid {
                confirmPasswordtxt.becomeFirstResponder()
            }
            self.passwordErrorLbl.text = message
            self.passwordErrorLbl.textColor = UIColor.red
            UIView.animate(withDuration: 0.25, animations: {
                self.passwordErrorLbl.isHidden = valid
            })
        case confirmPasswordtxt:
            if valid {
                emailTxt.becomeFirstResponder()
            }
            self.confirmPasswordErrorLbl.text = message
            self.confirmPasswordErrorLbl.textColor = UIColor.red
            UIView.animate(withDuration: 0.25, animations: {
                self.confirmPasswordErrorLbl.isHidden = valid
            })
        case emailTxt:
            if valid {
                mobileTxt.becomeFirstResponder()
            }
            self.emailErrorLbl.text = message
            self.emailErrorLbl.textColor = UIColor.red
            UIView.animate(withDuration: 0.25, animations: {
                self.emailErrorLbl.isHidden = valid
            })
        case mobileTxt:
            if valid {
                mobileTxt.resignFirstResponder()
            }
            self.mobileErrorLbl.text = message
            self.mobileErrorLbl.textColor = UIColor.red
            UIView.animate(withDuration: 0.25, animations: {
                self.mobileErrorLbl.isHidden = valid
            })
        default:
            mobileTxt.becomeFirstResponder()
        }
        return true
    }
}



