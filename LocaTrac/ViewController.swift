//
//  ViewController.swift
//  LocaTrac
//
//  Created by Raghuveer Beti on 23/04/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager!
    var lastCoordinate:CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType(rawValue: 0)!
        mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        
    }
    
    // Mark LocationManager Delegate Methods
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        
        
        if let oldLocationNew = oldLocation as CLLocation?{
            let oldCoordinates = oldLocationNew.coordinate
            let newCoordinates = newLocation.coordinate
            var area = [oldCoordinates, newCoordinates]
            let polyline = MKPolyline(coordinates: &area, count: area.count)
            mapView.addOverlay(polyline)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let newCoordinate = locations.last?.coordinate {
            
            let area = [lastCoordinate ?? newCoordinate, newCoordinate]
            
            let polyline = MKPolyline(coordinates: area, count: area.count)
            mapView.addOverlay(polyline)
            lastCoordinate = newCoordinate
        }
        
    }
    
    // Mark MKMapView Delegate Methods
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let pr = MKPolylineRenderer(overlay: overlay)
        pr.strokeColor = .systemRed
        pr.lineWidth = 3
        return pr
        
    }
    
    
}

