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
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
}

extension WeatherModel {
    static func placeholder() -> WeatherModel {
       return WeatherModel(conditionID: 0, cityName: "--", temperature: 0)
    }
}
