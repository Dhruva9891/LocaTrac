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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }


}

