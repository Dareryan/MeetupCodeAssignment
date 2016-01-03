//
//  UserLocationManager.swift
//  MeetupCodeAssignment
//
//  Created by Dare Ryan on 1/3/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//
import CoreLocation
import UIKit

protocol UserLocationManagerDelegate {
    func locationManagerDidUpdateLocation(sender: UserLocationManager, location: CLLocation)
}

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var delegate:UserLocationManagerDelegate?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        if let currentLocation = manager.location {
            delegate?.locationManagerDidUpdateLocation(self, location: currentLocation)
        }
    }
    
    func updateCurrentUserLocation() {
        locationManager.startUpdatingLocation()
    }

}
