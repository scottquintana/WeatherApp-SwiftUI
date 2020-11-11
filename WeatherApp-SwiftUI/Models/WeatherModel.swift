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
}

//MARK: - Placeholder Extension

extension WeatherModel {
    static func placeholder() -> WeatherModel {
       return WeatherModel(conditionID: 0, cityName: "--", temperature: 0)
    }
}
