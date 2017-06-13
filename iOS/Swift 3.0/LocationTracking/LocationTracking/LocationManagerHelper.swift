//
//  LocationManagerHelper.swift
//  LocationTracking
//
//  Created by Shridhar Mali on 6/12/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//



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
    var timer = Timer()
    var isTimerSetForSpeed: Bool = false
    var isSpeedChanged: Bool = false
    var currentTimeInterval: Int = 0
    var nextTimeInterval:Int = 0
    
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
    
    public func locationUpdatesAsPerCalculatedSpeedOfVehicle() {
    
        // Manual testing for speed uses Textfield on the home view controller
       /* if speedInKmPerHour != previousSpeedInKmPerHour && previousSpeedInKmPerHour > 0.0 {
            isSpeedChanged = true
        } else {
            isSpeedChanged = false
        }*/
        
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
                setTimer(timeInterval: 300) // 60 * 5
                previousSpeedInKmPerHour = speedInKmPerHour
                currentTimeInterval = 300
                nextTimeInterval = 120
            }
        case 30..<60:
            // capture location after 2 mins
            print("30..<60 KM/h")
            if !isTimerSetForSpeed {
                stopTimer()
                setTimer(timeInterval: 120) // 60 * 2
                previousSpeedInKmPerHour = speedInKmPerHour
                currentTimeInterval = 120
                nextTimeInterval = 60
            } else {
                
            }
        case 60..<80:
            // capture location after 1 mins
            print("60..<80 KM/h")
            if !isTimerSetForSpeed {
                stopTimer()
                setTimer(timeInterval: 60)
                previousSpeedInKmPerHour = speedInKmPerHour
                currentTimeInterval = 60
                nextTimeInterval = 30
            }
        case 80..<500:
            // capture location after 30 secs
            print("80..<500 KM/h")
            if !isTimerSetForSpeed {
                stopTimer()
                setTimer(timeInterval: 30) // 30 sec
                previousSpeedInKmPerHour = speedInKmPerHour
                currentTimeInterval = 30
                nextTimeInterval = 60
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
        //print("**************Capture location now...***********")
        //print("Capture user location is \(userLocation)")
        
        saveUserLocationInFile()
        // Save user location in DB
        saveUserLocationInDB()
    }
    
    //MARK:- Save User Location In File
    func saveUserLocationInFile() {
        let fileManager = FileManager.default
        let dir: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileurl = dir.appendingPathComponent("locations.txt")
        let headingText = "\t\t Time \t\t\t\t Latitude \t\t\t Longitude \t\t\t Current time interval \t\t Next time interval \n"
        let separator = "--------------------------------------------------------------------------------------------------------------------------------"
        let contentToWrite = " \(headingText) \(Date().addingTimeInterval(0)) \t \(latitude) \t\t\t \(longitude) \t\t\t\t\t \(currentTimeInterval) \t\t\t\t\t\t \(nextTimeInterval) \n \(separator) \n"
        let data = contentToWrite.data(using: .utf8, allowLossyConversion: false)!
        
        if fileManager.fileExists(atPath: fileurl.path) {
            do {
                let fileHandle = try FileHandle(forWritingTo: fileurl)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } catch let error {
                print("file handle failed \(error.localizedDescription)")
            }
        } else {
            do {
            _ = try data.write(to: fileurl, options: .atomic)
            } catch let error {
                print("cant write \(error.localizedDescription)")
            }
        }
        readFile()
    }
    
    func readFile() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask , true)
        let docDir = path[0]
        let sampleFilePath = docDir.appendingFormat("/locations.txt")
        do {
            let contentOfFile = try String(contentsOfFile: sampleFilePath, encoding: .utf8)
            print("file content is: \(contentOfFile)")
        } catch {
            print("Error while read file")
        }
    }
    
    // MARK:- Save User Location In DB
    func saveUserLocationInDB() {
        print("saveUserLocationInDB")
        let objDBHelper = DBHelper.instance
        objDBHelper.saveLocationUpdatedDataInLocalDB(time: userLocation.timestamp, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, currentTimeInterval: currentTimeInterval, nextTimeInterval: nextTimeInterval, speed: speedInKmPerHour)
    }
}
// MARK:- CLLocationManagerDelegate
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
            if speedInKmPerHour != previousSpeedInKmPerHour && previousSpeedInKmPerHour > 0.0 {
                isSpeedChanged = true
            } else {
                isSpeedChanged = false
            }
            locationUpdatesAsPerCalculatedSpeedOfVehicle()
        }
        
        // Create a location
        userLocation = CLLocation(latitude: latitude, longitude: longitude)
        print("User location is \(userLocation)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the current location of user \(error.localizedDescription)")
    }
}
