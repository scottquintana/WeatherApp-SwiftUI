//
//  CurrentWeatherVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI
import Combine

class CurrentWeatherVM: ObservableObject {
    
    @Published var currentWeather = WeatherModel.placeholder()
    var currentForecast = [DailyWeather]()
    @ObservedObject private var locationManager = LocationManager()
    
    private var cancellableNetwork: AnyCancellable?
    private var cancellableLocation: AnyCancellable?

    
    var cityName: String {
        return self.currentWeather.cityName
    }
    
    var conditionId: String {
        return WeatherConditionHelper.getImageFromConditionId(conditionId: self.currentWeather.conditionID)
    }
    
    var condition: String {
        return currentWeather.condition
    }
    
    var currentTempString: String {
        return String(format: "%.0f", currentWeather.temperature)
    }
    
    var feelsLike: String {
        return String(format: "%.0f", currentWeather.feelsLike)
    }
    
    var humidity: String {
        return "\(currentWeather.humidity)%"
    }
    
    var currentTime: Date {
        return currentWeather.currentDT
    }
    
    var sunriseTime: Date {
        return currentWeather.sunrise
    }
    
    var sunsetTime: Date {
        return currentWeather.sunset
    }
        
    var wind: String {
        return "\(currentWeather.windSpeed) mph \(WindHelper.windDirection(currentWeather.windDeg))"
    }
    
    var isNight: Bool {
        let currentTime = currentWeather.currentDT
        let sunrise = currentWeather.sunrise
        let sunset = currentWeather.sunset
        
        return !(currentTime > sunrise && currentTime < sunset)
    }

    
    init() {
        cancellableLocation = locationManager.objectWillChange
            .sink { _ in
                self.getCurrentWeather()
            }
    }
    
    
    func getCurrentWeather() {
        self.cancellableNetwork = NetworkManager.shared
                                    .getWeatherByLocation(lat: locationManager.userLatitude,
                                                          long: locationManager.userLongitude)
            .sink(receiveCompletion: { _ in  },
                  receiveValue: { weather in
                    self.currentWeather = WeatherModel(conditionID: weather.current.weather[0].id,
                                                       cityName: self.locationManager.locationName,
                                                       temperature: weather.current.temp,
                                                       feelsLike: weather.current.feelsLike,
                                                       currentDT: weather.current.dt,
                                                       humidity: weather.current.humidity,
                                                       sunrise: weather.daily[0].sunrise,
                                                       sunset: weather.daily[0].sunset,
                                                       windSpeed: weather.current.windSpeed,
                                                       windDeg: weather.current.windDeg,
                                                       condition: weather.current.weather[0].main
                                                        )
                    self.currentForecast = weather.daily
                  })
    }
}
