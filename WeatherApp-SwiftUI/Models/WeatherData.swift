//
//  CurrentWeather.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import Foundation

struct WeatherData: Codable {
    let dt: Date
    let main: Main
    let wind: Wind
    let sys: Sys
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Sys: Codable {
    let sunrise: Date
    let sunset: Date
}


struct Weather: Codable {
    let id: Int
}



