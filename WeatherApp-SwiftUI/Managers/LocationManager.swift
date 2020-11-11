//
//  LocationManager.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject{
    
    @Published var userLatitude: Double = 0 //36.149870
    @Published var userLongitude: Double = 0 //-86.866950
    @Published var locationName: String = "--"
    private let locationManager = CLLocationManager()
    
    var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let location = locations.last else { return }
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        self.getPlace(for: location) { placemark in
            guard let placemark = placemark else { return }
            
            var output = ""
            
            if let town = placemark.locality {
                output = output + "\(town)"
            }
            
            if let state = placemark.administrativeArea {
                output = output + ", \(state)"
            }

            self.locationName = output
        }
    }
}

//MARK: - Location Name Extension

extension LocationManager {
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
