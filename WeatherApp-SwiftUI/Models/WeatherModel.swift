//
//  WeatherModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let currentDT: Date
    let humidity: Double
    let sunrise: Date
    let sunset: Date
    let windSpeed: Double
    let windDeg: Double
    let condition: String
}

//MARK: - Placeholder Extension

extension WeatherModel {
    static func placeholder() -> WeatherModel {
       return WeatherModel(conditionID: 0,
                           cityName: "--",
                           temperature: 0,
                           feelsLike: 0,
                           currentDT: Date(),
                           humidity: 0,
                           sunrise: Date(),
                           sunset: Date(),
                           windSpeed: 0,
                           windDeg: 0,
                           condition: ""
                           
       )
    }
}
