//
//  LocationManagerHelper.swift
//  MapView
//
//  Created by Shridhar Mali on 1/10/17.
//  Copyright © 2017 TIS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
public class LocationManagerHelper: NSObject {
    let locationManager = CLLocationManager()
    static let sharedInstance = LocationManagerHelper()
    var latitude = Double()
    var longitude = Double()
    var userLocation = CLLocation()
    
    public func updateUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    public func getLocation(latitude: Double, longitude: Double) -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension LocationManagerHelper: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = manager.location
        if currentLocation != nil {
            latitude = (manager.location?.coordinate.latitude)!
            longitude = (manager.location?.coordinate.longitude)!
            print("latitude :\(latitude)")
            print("longitude :\(longitude)")
        }
        
        // 1 Create a location
        userLocation = CLLocation(latitude: latitude, longitude: longitude)
        print(userLocation)
        // userLocation = CLLocationCoordinate2D(latitude:latitude, longitude: longitude)
        // locationManager.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the current location of user \(error.localizedDescription)")
    }
}
