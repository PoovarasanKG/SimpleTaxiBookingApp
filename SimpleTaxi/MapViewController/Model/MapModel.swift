//
//  MapModel.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 18/07/23.
//


import CoreLocation

struct DriverDetails {
    
    let driverId: Int?
    let driverName: String?
    let driverCoordinates: CLLocationCoordinate2D?
    let distance : Double?
    let driverFair: Int?
   
    
    init(driverId: Int?, driverName: String?, driverCoordinates: CLLocationCoordinate2D?, distance: Double?, driverFair: Int?) {
        self.driverId = driverId
        self.driverName = driverName
        self.driverCoordinates = driverCoordinates
        self.driverFair = driverFair
        self.distance = 0
    }
}
