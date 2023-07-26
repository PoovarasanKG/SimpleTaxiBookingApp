//
//  MapViewController.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 18/07/23.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView?
    @IBOutlet weak var bookNowButton: UIButton?
    
    var viewModel: MapViewModel?
    var currentLocationMarker: GMSMarker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMethod()
        
    }
    
    // MARK: IBAction
    @IBAction func bookNowAction(_ sender: UIButton) {
        
        if let nearbyDriver = viewModel?.getNearByDrivers().first {
            
            let profileViewController = ProfileViewController.initViewController(nearByDriverDetails: nearbyDriver)
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        
        LocationManager.shared.startUpdateLocation(delegate: self)
    }
    
    
}

// MARK: Setup Methods
extension MapViewController {
    
    static func initViewController() -> MapViewController {
        
        let mapViewController = MapViewController()
        mapViewController.viewModel = MapViewModel()
        return mapViewController
    }
    
    func setupMethod() {
        self.title = "Book Taxi"
        self.view.backgroundColor = UIColor.lightGray
        currentLocationMarker = GMSMarker()
        LocationManager.shared.startUpdateLocation(delegate: self)
        
        bookNowButton?.backgroundColor = .clear
        bookNowButton?.layer.cornerRadius = 15
        bookNowButton?.layer.borderWidth = 3
        bookNowButton?.layer.borderColor = UIColor.black.cgColor
        
        updateDriverMarkers()
    }
    
    func updateDriverMarkers() {
        
        for maker in viewModel?.getDriverMarkers() ?? [] {
            
            maker.map = mapView
        }
    }
    
    func adjustBookNowButton() {
        
        let nearByDrivers = viewModel?.getNearByDrivers()
        
        
        if nearByDrivers?.isEmpty ?? true {
            bookNowButton?.isUserInteractionEnabled = false
            bookNowButton?.backgroundColor = UIColor.gray
            
        } else {
            bookNowButton?.isUserInteractionEnabled = true
            bookNowButton?.backgroundColor = UIColor(hexString: "#34C759")
            
        }
    }
}

// MARK: Location Manager Methods
extension MapViewController: LocationManagerDelegate {
    
    func didUpdateLocation() {
        
        updateMapViewForUser()
        adjustBookNowButton()
    }
    
    func updateMapViewForUser() {
        
        
        if let currentLocation = LocationManager.shared.currentLocation {
            
            let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: 11.0)
            mapView?.camera = camera
            
            
            currentLocationMarker?.position = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            currentLocationMarker?.snippet = "Current Location"
            currentLocationMarker?.map = mapView
        }
    }
    
}
