//
//  MapViewModel.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 18/07/23.
//

import CoreLocation
import GoogleMaps

class MapViewModel {
    
    var driverList: [DriverDetails] = []
    
    init() {
        
        loadDriverList()
    }
    
    func loadDriverList() {
        
        let driver1 = DriverDetails(driverId: 1, driverName: "John", driverCoordinates: CLLocationCoordinate2D(latitude: 11.068500, longitude: 77.244938), distance: 10, driverFair: 30)
        let driver2 = DriverDetails(driverId: 2, driverName: "Smith", driverCoordinates: CLLocationCoordinate2D(latitude: 11.067306, longitude: 77.244885), distance: 30, driverFair: 10)
        let driver3 = DriverDetails(driverId: 3, driverName: "David", driverCoordinates: CLLocationCoordinate2D(latitude: 11.071086, longitude: 77.279999), distance: 20, driverFair: 60)
        
        driverList = [driver1, driver2, driver3]
    }
    
    func getDriverMarkers() -> [GMSMarker] {
        
        var driverMarkers: [GMSMarker] = []
        
        for driverDetail in driverList {
            
            if let driverCoordinate = driverDetail.driverCoordinates {
                
                let marker = GMSMarker()
                marker.position = driverCoordinate
                marker.snippet = "Driver Location" + " " + (driverDetail.driverId?.description ?? "")
                
                let imageView = UIImageView()
                imageView.frame.size = CGSize(width: 60, height: 60)
                imageView.image = UIImage(named: "carImage")
                imageView.contentMode = .scaleAspectFit
                marker.iconView = imageView
                
                driverMarkers.append(marker)
                
            }
        }
        
        return driverMarkers
    }
    
    func getNearByDrivers() -> [DriverDetails] {
        
        if let currentCoordinate = LocationManager.shared.currentLocation {
            
            let currentLocation = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
            var nearByDrivers: [DriverDetails] = []
            
            for driverDetails in driverList {
                
                if let driverCoordinate = driverDetails.driverCoordinates {
                    
                    let driverLocation = CLLocation(latitude: driverCoordinate.latitude, longitude: driverCoordinate.longitude)
                    let distanceKM = currentLocation.distance(from: driverLocation) / 1000
                    
                    if distanceKM <= 1 {
                        
                        nearByDrivers.append(driverDetails)
                        
                    }
                }
            }
            
            let sortedDrivers = nearByDrivers.sorted { (driver1, driver2) -> Bool in
                if let fair1 = driver1.driverFair, let fair2 = driver2.driverFair {
                    if fair1 != fair2 {
                        return fair1 < fair2
                    }
                }
                // If driverFair is nil or both driverFairs are equal, sort based on distance
                let location1 = CLLocation(latitude: driver1.driverCoordinates!.latitude, longitude: driver1.driverCoordinates!.longitude)
                let location2 = CLLocation(latitude: driver2.driverCoordinates!.latitude, longitude: driver2.driverCoordinates!.longitude)
                return location1.distance(from: currentLocation) < location2.distance(from: currentLocation)
            }
            
            print("Sorted Drivers with amount and distance:", sortedDrivers)
            return sortedDrivers
        }
        return []
    }
}
