//
//  LocationManager.swift
//  Five
//
//  Created by Goga Eusebiu on 28.03.2022.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager: CLLocationManager?
    var userLocation = CLLocation(latitude: 46.4415519, longitude: 22.8976847)
    
    func checkIfUserLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("location not enabled")
        }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("no access")
        case .authorizedAlways, .authorizedWhenInUse:
            userLocation = locationManager.location ?? userLocation
        @unknown default:
            break
        }
    }
}
