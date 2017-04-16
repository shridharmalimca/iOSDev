//
//  APIAutoComplete.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import Gloss

//Object Mapping of APIAutoComplete
public struct APIAutoCompletePlaces: Decodable {
    let predictions: [Predictions]?
    public init?(json: JSON) {
        self.predictions = "predictions" <~~ json
    }
}

public struct Predictions: Decodable {
    let description: String?
    let placeId: String?
    let structuredFormatting: StructuredFormatting?
    public init?(json: JSON) {
        self.description = "description" <~~ json
        self.placeId = "place_id" <~~ json
        self.structuredFormatting = "structured_formatting" <~~ json
    }
}

public struct StructuredFormatting: Decodable {
    let secondaryText: String?
    public init?(json: JSON) {
        self.secondaryText = "secondary_text" <~~ json
    }
}

//MARK:- APIAutoCompleteResponse
public enum APIAutoCompleteResponse {
    case error(APIError)
    case success(APIAutoCompletePlaces)
}

//MARK:- Server Extention APIAutoComplete
extension Server {
    public struct APIAutoComplete {
        static func getPlacesHandler(_ places: [String: AnyObject]) -> APIAutoCompletePlaces? {
            guard let obj = APIAutoCompletePlaces(json: places) else {
                return nil
            }
            return obj
        }
        
        //Get place in autocomplete formate using search string 
        public static func invokeAPIAutoComplete(searchText: String, _ handler: @escaping(APIAutoCompleteResponse) -> Void) -> URLSessionDataTask {
            // Google autocomplete API for getting search places
            let apiAutoComplete = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(searchText)&types=geocode&key=\(Server.URLs.apiKey)"
            let escapedString = apiAutoComplete.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let rqst = SRKRequestManager.generateRequest(escapedString!,
                                                         dictionaryOfHeaders: nil,
                                                         postData: nil,
                                                         requestType: .Get,
                                                         timeOut: 60)
            return SRKRequestManager.invokeRequestForJSON(rqst) { (response: JSONResponse) in
                SRKUtility.hideProgressHUD()
                let apiAutoCompleteResponse = Server.handleResponse(response)
                switch apiAutoCompleteResponse {
                case let .successWithArray(arrayOfRawPlaces):
                    print(arrayOfRawPlaces)
                    handler(APIAutoCompleteResponse.error(APIError.invalidResponseReceived))
                case let .successWithDictionary(rawPlaces):
                    if let businesscard = Server.APIAutoComplete.getPlacesHandler(rawPlaces as [String : AnyObject]) {
                        handler(APIAutoCompleteResponse.success(businesscard))
                    } else {
                        handler(APIAutoCompleteResponse.error(APIError.invalidResponseReceived))
                    }
                case let .error(error):
                    handler(APIAutoCompleteResponse.error(error))
                }
            }
        }
    }
}
