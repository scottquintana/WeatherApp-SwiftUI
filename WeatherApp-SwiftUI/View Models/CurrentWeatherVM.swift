//
//  CurrentWeatherVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI
import Combine

class CurrentWeatherVM: ObservableObject {
    
    private var cancellableNetwork: AnyCancellable?
    private var cancellableLocation: AnyCancellable?
    
    @Published private var weather = WeatherModel.placeholder()
    @ObservedObject private var locationManager = LocationManager()
    
    var currentTempString: String {
        return self.weather.temperatureString
    }
    
    var cityName: String {
        return self.weather.cityName
    }
    
    
    init() {
        cancellableLocation = locationManager.objectWillChange
            .sink { _ in
                self.getCurrentWeather()
            }
      
    }
    
    func getCurrentWeather() {
        self.cancellableNetwork = NetworkManager.shared.getWeatherByCity(lat: locationManager.userLatitude, long: locationManager.userLongitude)            .sink(receiveCompletion: { _ in }, receiveValue: { weather in
            self.weather = WeatherModel(conditionID: weather.weather[0].id, cityName: self.locationManager.locationName, temperature: weather.main.temp)
            })
    }
    
}
