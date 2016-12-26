//
//  LocalizationKeys.swift
//  Localization
//
//  Created by Shridhar Mali on 12/26/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

extension String {
    public static func localize(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
public func LS(key: String) -> String {
    return String.localize(key: key)
}


let Hello = LS(key:"Hello")
let OK = LS(key: "Ok")
