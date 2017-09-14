//
//  Constants.swift
//  ExceptionHandling
//
//  Created by Shridhar Mali on 9/12/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

//Associative Enumerations
public enum AppError: Error {
    case invalidResponseReceived
    case invalidRequestReceived
    case customMessage(String)
    case error(Error)
    case networkError
}

public enum AppResponse {
    case error(AppError)
    case successWithDictionary([String: Any]) // for eg return dict
    case successWithArray([[String: Any]]) // for eg array of dict
}

public enum JSONResponse {
    case array([AnyObject], URLResponse?)
    case dictionary([String: AnyObject], URLResponse?)
    case error(URLResponse?, Error)
}

struct Server {
    let apiUrl = ""
    
    func generateRequest() {
        // TO:DO
    }
    
    public static func handleResponse(_ jsonResponse: JSONResponse) -> AppResponse {
        switch jsonResponse {
        case let .array(array, _):
            print("Invalid array received \(array)")
            return AppResponse.error(AppError.invalidResponseReceived)
        case let .dictionary(dictOfRespnse, _):
            return AppResponse.successWithDictionary(dictOfRespnse)
        case let .error(_, error):
            return AppResponse.error(AppError.error(error))
            
        }
    }
}
