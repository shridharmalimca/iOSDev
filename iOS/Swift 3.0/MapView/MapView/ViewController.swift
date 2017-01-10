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
class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let objLocationManager = LocationManagerHelper.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshMap))
        objLocationManager.updateUserLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnnotation()
    }
    func refreshMap() {
        addAnnotation()
    }
    func addAnnotation() {
        print(objLocationManager.userLocation.coordinate.latitude)
        print(objLocationManager.userLocation.coordinate.longitude)
        
        // 2 Create span
        var span = MKCoordinateSpanMake(0.05, 0.05)
        span.latitudeDelta = 0.02
        span.longitudeDelta = 0.02
        let region = MKCoordinateRegion(center: objLocationManager.userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
        // 3 Add Annotation on map
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = objLocationManager.userLocation.coordinate
        annotation.title = "Title"
        annotation.subtitle = "SubTitle"
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

