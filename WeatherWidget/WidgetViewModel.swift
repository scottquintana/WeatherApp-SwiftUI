//
//  WidgetViewModel.swift
//  WeatherWidgetExtension
//
//  Created by Scott Quintana on 12/23/20.
//

import SwiftUI
import Combine
import CoreLocation

final class WidgetViewModel {
    private var subscriptions = Set<AnyCancellable>()
    
    var locationName: String?
    
    func getWidgetWeather(userLocation: CLLocation, completion: @escaping (WeatherData) -> Void) {
        getPlace(for: userLocation) { [weak self] placemark in
            guard let self = self else { return }
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
        
        NetworkManager.shared.getWeatherByLocation(lat: userLocation.coordinate.latitude, long: userLocation.coordinate.longitude)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { weather in
                    var currentWeather = weather
                    currentWeather.cityName = self.locationName
                   completion(currentWeather)
                  })
            .store(in: &subscriptions)
    }
    
    
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
