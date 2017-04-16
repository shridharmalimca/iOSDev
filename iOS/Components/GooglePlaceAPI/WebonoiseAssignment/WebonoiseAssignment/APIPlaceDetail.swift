//
//  APIPlaceDetail.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import Gloss

//Object Mapping of APIPlaceDetail
public struct APIPlaceDetailInformation: Decodable {
    let result: Result?
    public init?(json: JSON) {
        self.result = "result" <~~ json
    }
}
public struct Result: Decodable {
    let geometry: Geometry?
    let name: String?
    let photos: [Photos]?
    public init?(json: JSON) {
        self.geometry = "geometry" <~~ json
        self.name = "name" <~~ json
        self.photos = "photos" <~~ json
    }
}

public struct Geometry: Decodable {
    let location: Location?
    public init?(json: JSON) {
        self.location = "location" <~~ json
    }
}

public struct Location: Decodable {
    let latitude: Double?
    let longitude: Double?
    public init?(json: JSON) {
        self.latitude = "lat" <~~ json
        self.longitude = "lng" <~~ json
    }
}

public struct Photos: Decodable {
    let photoReference: String?
    let height: Int?
    let width: Int?
    
    public init?(json: JSON) {
        self.photoReference = "photo_reference" <~~ json
        self.height = "height" <~~ json
        self.width = "width" <~~ json
    }
}

//MARK:- APIPlaceDetailResponse
public enum APIPlaceDetailResponse {
    case error(APIError)
    case success(APIPlaceDetailInformation)
}

//MARK:- Server Extension APIPlaceDetail
extension Server {
    public struct APIPlaceDetail {
        static func getPlaceDetailHandler(_ placeDetails: [String: AnyObject]) -> APIPlaceDetailInformation? {
            guard let obj = APIPlaceDetailInformation(json: placeDetails) else {
                return nil
            }
            return obj
        }
        // Get Place details using placeId 
        public static func invokeAPIPlaceDetail(placeId: String, _ handler: @escaping(APIPlaceDetailResponse) -> Void) -> URLSessionDataTask {
            // Google Place Details API
            let apiPlaceDetails = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(Server.URLs.apiKey)"
            let escapedString = apiPlaceDetails.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let rqst = SRKRequestManager.generateRequest(escapedString!,
                                                         dictionaryOfHeaders: nil,
                                                         postData: nil,
                                                         requestType: .Get,
                                                         timeOut: 60)
            return SRKRequestManager.invokeRequestForJSON(rqst) { (response: JSONResponse) in
                let apiPlaceDetailResponse = Server.handleResponse(response)
                switch apiPlaceDetailResponse {
                case let .successWithArray(arrayOfRawPlaces):
                    print(arrayOfRawPlaces)
                    handler(APIPlaceDetailResponse.error(APIError.invalidResponseReceived))
                case let .successWithDictionary(placeDetails):
                    if let placeDetailsDictionary = Server.APIPlaceDetail.getPlaceDetailHandler(placeDetails as [String : AnyObject]) {
                        handler(APIPlaceDetailResponse.success(placeDetailsDictionary))
                    } else {
                        handler(APIPlaceDetailResponse.error(APIError.invalidResponseReceived))
                    }
                case let .error(error):
                    handler(APIPlaceDetailResponse.error(error))
                }
            }
        }
    }
}
