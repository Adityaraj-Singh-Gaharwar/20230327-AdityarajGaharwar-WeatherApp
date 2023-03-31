//
//  HSLocation.swift
//  Blast
//
//  Created by cis on 02/08/18.
//  Copyright © 2018 cis. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import CoreLocation

class CurrentLocation: NSObject, CLLocationManagerDelegate {
    //Variables
    static let sharedInstance: CurrentLocation = CurrentLocation()
    var locationManager:CLLocationManager! = nil
    typealias completionHanlder = (_ lat: String, _ long: String) -> Void
    var completion: completionHanlder! = nil
    
    //Functions
    func getCurrentLocation(location:@escaping (String,String)->Void) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            self.completion =  { (lat, lng) in
                location(lat,lng)
            }
        }
    }
    //Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let isLocation = locations.first {
            completion("\(isLocation.coordinate.latitude)","\(isLocation.coordinate.longitude)")
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            locationManager = nil
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let isLocation = manager.location {
            completion("\(isLocation.coordinate.latitude)","\(isLocation.coordinate.longitude)")
        } else {
            completion("\(0.0)","\(0.0)")
        }
    }
}
