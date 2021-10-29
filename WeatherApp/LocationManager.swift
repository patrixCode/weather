//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Patrik Seben on 20/07/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocationName(whit loation: CLLocation, completion: @escaping ((String?) -> Void)) {
         let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(loation, preferredLocale: .current) {
            placemarks,
            error in
            guard let place = placemarks?.first, error == nil else { completion(nil)
                return
                
            }
            
            print(place)
            
            var name = ""
            
            if let adminRegion = place.administrativeArea {
                name += ", \(adminRegion)"
            }
            
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
    return
    }
    completion?(location)
    manager.stopUpdatingLocation()
    }
}
