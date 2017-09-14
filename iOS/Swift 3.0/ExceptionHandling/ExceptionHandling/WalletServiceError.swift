//
//  ApplicationError.swift
//  ExceptionHandling
//
//  Created by Shridhar Mali on 9/12/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class WalletServiceError: NSObject {
    
    var userInfo : [AnyHashable: Any] {
        return [NSLocalizedDescriptionKey: ""]
    }
    
    
    class func showErrorAsPerHttpStatusCode(statusCode: Int) -> Error {
        var description = String()
        switch statusCode {
        case 400: break // Bad Request   // After implementation remove break and default
        case 403: break// Forbidden
        case 404: break// Not Found
        case 500: break//Internal server error
        default: break
        }
        return NSError(domain: "WalletServiceError", code: statusCode, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    
    
}
