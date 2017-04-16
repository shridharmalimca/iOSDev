//
//  Constants.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

//MARK:- APIResponse
public enum APIResponse {
    case error(APIError)
    case successWithDictionary([String: Any])
    case successWithArray([[String: Any]])
}

//MARK:- APIError
public enum APIError: Error {
    case invalidResponseReceived
    case invalidRequestReceived
    case customMessage(String)
    case error(Error)
}

//MARK:-
public struct Server {
    public struct URLs {
        // Google API Key for google place API web service
        public static let apiKey = "AIzaSyB10Z3SojE052YjN3ZSlq6g9i2FVEup3CA"
    }
    
    //Handle response which is get from google places api
    public static func handleResponse(_ jsonResponse: JSONResponse) -> APIResponse {
        switch jsonResponse {
        case let .array(array, _):
            print("Invalid array received \(array)")
            return APIResponse.error(APIError.invalidResponseReceived)
        case let .dictionary(dictionaryOfResponse, _):
            if let status = dictionaryOfResponse["status"] {
                if status as! String == "OK" {
                    print(status)
                    return APIResponse.successWithDictionary(dictionaryOfResponse)
                } else if status as! String == "OVER_QUERY_LIMIT" {
                    return APIResponse.error(APIError.customMessage(dictionaryOfResponse["error_message"] as! String))
                } else {
                    // Error
                    return APIResponse.error(APIError.invalidResponseReceived)
                }
            } else {
                // Error
                return APIResponse.error(APIError.invalidResponseReceived)
            }
            
        case let .error(_, error):
            return APIResponse.error(APIError.error(error))
        }
    }
    
    // Handle response google places photo api
    public static func handlePlacePhotResponse(_ jsonResponse: JSONResponse) -> APIResponse {
        switch jsonResponse {
        case let .array(array, _):
            print("Invalid array received \(array)")
            return APIResponse.error(APIError.invalidResponseReceived)
        case let .dictionary(dictionaryOfResponse, _):
           // print("Photo dict response is: \(dictionaryOfResponse)")
            return APIResponse.successWithDictionary(dictionaryOfResponse)
        case let .error(_, error):
            return APIResponse.error(APIError.error(error))
        }
    }
    
    
}
