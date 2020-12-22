//
//  CurrentWeather.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 12/22/20.
//

import Foundation

struct WeatherData: Codable {
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather: Codable {
    let dt: Date
    let sunrise: Date
    let sunset: Date
    let temp: Double
    let feelsLike: Double
    let humidity: Double
    let weather: [Weather]
    let windSpeed: Double
    let windDeg: Double

}

struct DailyWeather: Codable {
    let dt: Date
    let sunrise: Date
    let sunset: Date
    let temp: DailyTemp
    let weather: [Weather]
}

struct DailyTemp: Codable {
    let min: Double
    let max: Double
}

struct HourlyWeather: Codable {
    let dt: Date
    let temp: Double
    let weather: [Weather]
    let clouds: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
