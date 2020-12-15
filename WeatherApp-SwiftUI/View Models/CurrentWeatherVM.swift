//
//  CurrentWeatherVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI
import Combine

class CurrentWeatherVM: ObservableObject {
    
    @Published private var weather = WeatherModel.placeholder()
    @ObservedObject private var locationManager = LocationManager()
    
    private var cancellableNetwork: AnyCancellable?
    private var cancellableLocation: AnyCancellable?

    
    var cityName: String {
        return self.weather.cityName
    }
    
    var conditionId: String {
        return WeatherConditionHelper.getImageFromConditionId(conditionId: self.weather.conditionID)
    }
    
    var currentTempString: String {
        return String(format: "%.0f", weather.temperature)
    }
    
    var feelsLike: String {
        return String(format: "%.0f", weather.feelsLike)
    }
    
    var humidity: String {
        return "\(weather.humidity)%"
    }
    
    var sunriseTime: Date {
        return weather.sunrise
    }
    
    var sunsetTime: Date {
        return weather.sunset
    }
    
    var isDaytime: Bool {
        return weather.currentDT > weather.sunrise && weather.currentDT < weather.sunset
    }
    
    var wind: String {
        return "\(weather.windSpeed) mph \(WindHelper.windDirection(weather.windDeg))"
    }

    
    init() {
        cancellableLocation = locationManager.objectWillChange
            .sink { _ in self.getCurrentWeather() }
    }
    
    
    func getCurrentWeather() {
        self.cancellableNetwork = NetworkManager.shared.getWeatherByCity(lat: locationManager.userLatitude,
                                                                         long: locationManager.userLongitude)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { weather in
                    self.weather = WeatherModel(conditionID: weather.weather[0].id,
                                                cityName: self.locationManager.locationName,
                                                temperature: weather.main.temp,
                                                feelsLike: weather.main.feelsLike,
                                                currentDT: weather.dt,
                                                humidity: weather.main.humidity,
                                                sunrise: weather.sys.sunrise,
                                                sunset: weather.sys.sunset,
                                                windSpeed: weather.wind.speed,
                                                windDeg: weather.wind.deg
                    )
                  })
    }
}
