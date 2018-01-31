//
//  RegistrationModel.swift
//  CustomTableviewCell
//
//  Created by Shridhar Mali on 1/28/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
//

import UIKit

class RegistrationModel: NSObject {
    var userInfo = [User]()
    var fields = ["FirstName",
                  "LastName",
                  "Password",
                  "Confirm Password",
                  "Email",
                  "Mobile"]
    
    var errorMsg = ["Please enter name",
                    "Please enter last name",
                    "Please enter password",
                    "Please enter confirm password",
                    "Please enter email",
                    "Please enter mobile number"]
    
    
    var textFieldSuggesstions = ["First name allows only chars",
                    "Last name allows only chars",
                    "Password with 1 special char, 1 digit, max length 4",
                    "Confirm password with 1 special char, 1 digit, max length 4",
                    "Email allow '@' & '.com' only",
                    "Mobile number allow only 10 digits"]
    
    
    func configureCell() -> [User] {
        for (index, field) in fields.enumerated() {
            let user = User()
            user.fieldValue = field
            user.fieldErrorMsg = errorMsg[index]
            user.isValid = true
            user.suggesstionMsg = textFieldSuggesstions[index]
            userInfo.append(user)
        }
        return userInfo
    }
}

class User {
    var fieldValue: String?
    var fieldErrorMsg: String?
    var placeholder: String?
    var isValid: Bool = false
    var suggesstionMsg: String?
}
