//
//  CurrentWeatherVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import Foundation
import Combine

class CurrentWeatherVM: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published private var weather = WeatherModel.placeholder()
    
    var currentTemp: String {
        return self.weather.temperatureString
    }
    
    
    init() {
        getCurrentWeather(cityName: "Nashville")
    }
    
    func getCurrentWeather(cityName: String) {
        self.cancellable = NetworkManager.shared.getWeatherByCity(city: cityName)
            .sink(receiveCompletion: { _ in }, receiveValue: { weather in
                self.weather = WeatherModel(conditionID: weather.weather[0].id, cityName: cityName, temperature: weather.main.temp)
            })
    }
    
}
