//
//  ViewController.swift
//  MapView
//
//  Created by Shridhar Mali on 12/9/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        // 1 Create a location
        let location = CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402)
        
        
        // 2 Create span 
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        // 3 Add Annotation on map 
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Title"
        annotation.subtitle = "SubTitle"
        mapView.addAnnotation(annotation)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("User current location is:\(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the current location of user \(error.localizedDescription)")
    }

}

