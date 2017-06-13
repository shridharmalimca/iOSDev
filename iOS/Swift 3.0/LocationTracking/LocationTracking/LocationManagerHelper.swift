//
//  LocationManagerHelper.swift
//  LocationTracking
//
//  Created by Shridhar Mali on 6/12/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//


enum SpeedLimits: Equatable {
    case uptoThirty
    case uptoSixty
    case uptoEighty
    case uptoHundred
}

import UIKit
import CoreLocation
class LocationManagerHelper: NSObject {
    let locationManager = CLLocationManager()
    static let sharedInstance = LocationManagerHelper()
    var latitude = Double()
    var longitude = Double()
    var userLocation = CLLocation()
    var speedInKmPerHour: Double = 0.0
    var previousSpeedInKmPerHour: Double = 0.0
    var timePassedInMins: Int = 0
    var isCrossedSpeedLimit: Bool = false
    var timer = Timer()
    var isTimerSetForSpeed: Bool = false
    var isSpeedChanged: Bool = false
    public func updateUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    public func stopLocationUpdate() {
        locationManager.stopUpdatingLocation()
    }
    
    public func getLocation(latitude: Double, longitude: Double) -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    public func calculate() {
    
        if speedInKmPerHour != previousSpeedInKmPerHour && previousSpeedInKmPerHour > 0.0 {
            isSpeedChanged = true
        } else {
            isSpeedChanged = false
        }
        
        if isSpeedChanged {
            if (speedInKmPerHour > 0 || speedInKmPerHour < 30) && previousSpeedInKmPerHour < 30 {
                if speedInKmPerHour > 30 {
                    isTimerSetForSpeed = false
                } else {
                    isTimerSetForSpeed = true
                }
            } else if (speedInKmPerHour > 30 || speedInKmPerHour < 60) && previousSpeedInKmPerHour < 60 {
                if speedInKmPerHour > 60 {
                    isTimerSetForSpeed = false
                } else {
                    isTimerSetForSpeed = true
                }
            } else if (speedInKmPerHour > 60 || speedInKmPerHour < 60) && previousSpeedInKmPerHour < 80 {
                if speedInKmPerHour > 80 {
                    isTimerSetForSpeed = false
                } else {
                    isTimerSetForSpeed = true
                }
            } else if previousSpeedInKmPerHour >= 80 || previousSpeedInKmPerHour >= 60 && speedInKmPerHour < 30 {
                isTimerSetForSpeed = false
            } else if (speedInKmPerHour > 80 || speedInKmPerHour < 80) &&  previousSpeedInKmPerHour < 500 {
                if speedInKmPerHour > 80 {
                    isTimerSetForSpeed = false
                } else {
                    isTimerSetForSpeed = true
                }
            }  else {
                isTimerSetForSpeed = false
            }
        }
        
        switch speedInKmPerHour {
        case 0..<30:
            // capture location after 5 mins
            print("0..<30 KM/h")
            if (!isTimerSetForSpeed) {
                stopTimer()
                setTimer(timeInterval: 10)// 300)
                previousSpeedInKmPerHour = speedInKmPerHour
                // _ = SpeedLimits(rawValue: 0)
            }
        case 30..<60:
            // capture location after 2 mins
            print("30..<60 KM/h")
            if !isTimerSetForSpeed {
                stopTimer()
                setTimer(timeInterval: 5) // 120)
                previousSpeedInKmPerHour = speedInKmPerHour
                // SpeedLimits(rawValue: 1)
            } else {
                
            }
        case 60..<80:
            // capture location after 1 mins
            print("60..<80 KM/h")
            if !isTimerSetForSpeed {
                stopTimer()
                setTimer(timeInterval: 3)// 60)
                previousSpeedInKmPerHour = speedInKmPerHour
                // _ = SpeedLimits.uptoEighty
            }
        case 80..<500:
            // capture location after 30 secs
            print("80..<500 KM/h")
            if !isTimerSetForSpeed {
                stopTimer()
                setTimer(timeInterval: 2)// 30)
                previousSpeedInKmPerHour = speedInKmPerHour
                // _ = SpeedLimits.uptoHundred
            }
        default:
            print("Device is at ideal position or invalid speed found")
        }
    }
    
    func setTimer(timeInterval: TimeInterval) {
        isTimerSetForSpeed = true
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(captureLocation), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        isTimerSetForSpeed = false
    }
    
    func captureLocation() {
        print("**************Capture location now...***********")
        print("Capture user location is \(userLocation)")
        // Save user location in DB
        saveUserLocationInDB()
        // isTimerSetForSpeed = false
    }
    
    func saveUserLocationInDB() {
        print("saveUserLocationInDB")
    }
    
    /*static func ==(lhs: SpeedLimits, rhs:SpeedLimits) -> Bool {
        switch (lhs, rhs) {
        case (.uptoThirty,  .uptoThirty):
            return true
        case (.uptoSixty, .uptoSixty):
            return true
        case (.uptoEighty, .uptoEighty):
            return true
        case (.uptoHundred, .uptoHundred):
            return true
        default:
            return false
        }
        return false
    }*/
}

extension LocationManagerHelper: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = manager.location {
            latitude = (manager.location?.coordinate.latitude)!
            longitude = (manager.location?.coordinate.longitude)!
            print("latitude :\(latitude)")
            print("longitude :\(longitude)")
            print("time stamp: \(String(describing: currentLocation.timestamp))")
            // location Manager return speed in mps(meter per second)
            let speedInMeterPerSecond = currentLocation.speed
            // formula for calculate meter per second to km/h.
            // km/h = mps * 3.6
            // 5m/sec = (5 * 3.6) = 18 km/h
             speedInKmPerHour = (speedInMeterPerSecond * 3.6)
           // print("speed \(speedInKmPerHour) Km/h")
           /* if speedInKmPerHour != previousSpeedInKmPerHour && previousSpeedInKmPerHour > 0.0 {
                isSpeedChanged = true
            } else {
                isSpeedChanged = false
            }
            calculate()
            */
        }
        
        // 1 Create a location
        userLocation = CLLocation(latitude: latitude, longitude: longitude)
        print("User location is \(userLocation)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the current location of user \(error.localizedDescription)")
    }
}
