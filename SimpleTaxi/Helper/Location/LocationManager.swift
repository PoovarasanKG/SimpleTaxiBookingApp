//
//  LocationManager.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 18/07/23.
//

import CoreLocation

protocol LocationManagerDelegate {
    
    func didUpdateLocation()
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    let locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    var delegate: LocationManagerDelegate?
    
    private override init() {
    
        locationManager = CLLocationManager()
        super.init()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func startUpdateLocation(delegate: LocationManagerDelegate? = nil) {
        
        if delegate != nil {
            self.delegate = delegate
        }
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        
        locationManager?.stopUpdatingLocation()
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
           startUpdateLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations",locations.first?.coordinate as Any)
        currentLocation = locations.first?.coordinate
        delegate?.didUpdateLocation()
        stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            // To prevent forever looping of `didFailWithError` callback
            locationManager?.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}



