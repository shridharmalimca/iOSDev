//
//  APIPlacePhoto.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import Gloss

//Object Mapping of APIPlacePhoto
public struct APIPlacePhotoInformation: Decodable {
    let imageUrl: AnyObject?
    public init?(json: JSON) {
        self.imageUrl = "imageUrl" <~~ json
    }
}

//MARK:- APIPlacePhotoReponse
public enum APIPlacePhotoReponse {
    case error(APIError)
    case success(APIPlacePhotoInformation)
}
//MARK:- Server Extension APIPlacePhoto
extension Server {
    public struct APIPlacePhoto {
        static func getPlacePhotoHandler(_ placePhoto: [String: AnyObject]) -> APIPlacePhotoInformation? {
            guard let obj = APIPlacePhotoInformation(json: placePhoto) else {
                return nil
            }
            return obj
        }
        
        // Get Place photo using photo reference 
        public static func invokeAPIPlacePhoto(photoReference: String, _ handler: @escaping(APIPlacePhotoReponse) -> Void) -> URLSessionDataTask {
            //Google Place photo API
            let apiPlacePhoto = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=\(Server.URLs.apiKey)"
            let escapedString = apiPlacePhoto.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let rqst = SRKRequestManager.generateRequest(escapedString!,
                                                         dictionaryOfHeaders: nil,
                                                         postData: nil,
                                                         requestType: .Get,
                                                         timeOut: 60)
            return SRKRequestManager.invokeRequestForJSON(rqst) { (response: JSONResponse) in
                let apiPlacePhotoResponse = Server.handlePlacePhotResponse(response)
                switch apiPlacePhotoResponse {
                case let .successWithArray(arrayOfRawPlaces):
                    print(arrayOfRawPlaces)
                    handler(APIPlacePhotoReponse.error(APIError.invalidResponseReceived))
                case let .successWithDictionary(placePhoto):
                    if let placePhotoDetailsDictionary = Server.APIPlacePhoto.getPlacePhotoHandler(placePhoto as [String : AnyObject]) {
                        handler(APIPlacePhotoReponse.success(placePhotoDetailsDictionary))
                    } else {
                        handler(APIPlacePhotoReponse.error(APIError.invalidResponseReceived))
                    }
                case let .error(error):
                    handler(APIPlacePhotoReponse.error(error))
                }
            }
        }
        
    }
}
