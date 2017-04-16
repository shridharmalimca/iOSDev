//
//  PlaceDetailModel.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class PlaceDetailModel: NSObject {
    static let shardInstance = PlaceDetailModel()
    var placeDetailsInfo: Result?
    var isPlacePhoto: Bool = false
    var counter: Int = 0
}
