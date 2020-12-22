//
//  CurrentWeatherVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI
import Combine

class CurrentWeatherVM: ObservableObject {
    
    @Published private var currentWeather = WeatherModel.placeholder()
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
    
    var currentTempString: String {
        return String(format: "%.0f", currentWeather.temperature)
    }
    
    var feelsLike: String {
        return String(format: "%.0f", currentWeather.feelsLike)
    }
    
    var humidity: String {
        return "\(currentWeather.humidity)%"
    }
    
    var sunriseTime: Date {
        return currentWeather.sunrise
    }
    
    var sunsetTime: Date {
        return currentWeather.sunset
    }
    
    var isDaytime: Bool {
        return currentWeather.currentDT > currentWeather.sunrise && currentWeather.currentDT < currentWeather.sunset
    }
    
    var wind: String {
        return "\(currentWeather.windSpeed) mph \(WindHelper.windDirection(currentWeather.windDeg))"
    }

    
    init() {
        cancellableLocation = locationManager.objectWillChange
            .sink { _ in
                self.getCurrentWeather() }
    }
    
    
    func getCurrentWeather() {
        self.cancellableNetwork = NetworkManager.shared.getWeatherByLocation(lat: locationManager.userLatitude,
                                                                         long: locationManager.userLongitude)
            .sink(receiveCompletion: { print ("completion: \($0)") },
                  receiveValue: { weather in
                    print (weather)
                    self.currentWeather = WeatherModel(conditionID: weather.current.weather[0].id,
                                                cityName: self.locationManager.locationName,
                                                temperature: weather.current.temp,
                                                feelsLike: weather.current.feelsLike,
                                                currentDT: weather.current.dt,
                                                humidity: weather.current.humidity,
                                                sunrise: weather.daily[0].sunrise,
                                                sunset: weather.daily[0].sunset,
                                                windSpeed: weather.current.windSpeed,
                                                windDeg: weather.current.windDeg
                    )
                    self.currentForecast = weather.daily
                  })
    }
}
