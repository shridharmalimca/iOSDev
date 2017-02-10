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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Draw", style: .plain, target: self, action: #selector(self.drawOnMap))
        
        objLocationManager.updateUserLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnnotation()
    }
    func refreshMap() {
        let overlays = self.mapView.overlays
        self.mapView.removeOverlays(overlays)
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

    
    // drawOnMap 
    func drawOnMap() {
        let alertController = UIAlertController(title: "Draw On Map", message: "", preferredStyle: .actionSheet)
        
        let circle = UIAlertAction(title: "Circle", style: .default) { (action: UIAlertAction) in
            self.drawCircle()
        }
        
        let polygoan = UIAlertAction(title: "Polygoan", style: .default) { (action: UIAlertAction) in
            self.drawPolygon()
        }
        
        let polyline = UIAlertAction(title: "Polyline", style: .default) { (action: UIAlertAction) in
            self.drawPolyline()
        }
        
        let route = UIAlertAction(title: "Route (BOM to PNR)", style: .default) { (action: UIAlertAction) in
            self.drawRoute()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(circle)
        alertController.addAction(polygoan)
        alertController.addAction(polyline)
        alertController.addAction(route)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    func drawCircle() {
        let circle = MKCircle(center: objLocationManager.userLocation.coordinate, radius: 300)
        self.mapView.add(circle)
    }
    
    func drawPolygon() {
        let locations = [CLLocationCoordinate2D(latitude: 19.0176147, longitude: 72.8561644), CLLocationCoordinate2D(latitude: 18.5204303,longitude: 73.8567437), CLLocationCoordinate2D(latitude: 19.0945700, longitude: 74.7384300), CLLocationCoordinate2D(latitude: 19.0176147, longitude: 72.8561644)]
        
        let polygon = MKPolygon(coordinates: locations, count: locations.count)
        self.mapView.add(polygon)
    }
    
    func drawPolyline() {
        let locations = [CLLocationCoordinate2D(latitude: 19.0176147, longitude: 72.8561644), CLLocationCoordinate2D(latitude: 18.5204303,longitude: 73.8567437)]
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        self.mapView.add(polyline)
    }
    
    func drawRoute() {
        // Draw Routes using MKPolyline 
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }
        
        if overlay is MKPolygon {
            let polygoan = MKPolygonRenderer(overlay: overlay)
            polygoan.fillColor = UIColor.red
            polygoan.strokeColor = UIColor.black
            polygoan.lineWidth = 1
            return polygoan
        }
        
        if overlay is MKPolyline {
            let line = MKPolylineRenderer(overlay: overlay)
            line.fillColor = UIColor.blue
            line.strokeColor = UIColor.red
            line.lineWidth = 2
            return line
        }
        return overlay as! MKOverlayRenderer
    }
}


