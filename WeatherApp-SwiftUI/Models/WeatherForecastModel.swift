//
//  WeatherForecastModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

import Foundation

struct WeatherForecastModel {
    let conditionID: Int
    let date: Date
    let tempHigh: Double
    let tempLow: Double
}

//MARK: - Placeholder Extension

extension WeatherForecastModel {
    static func placeholder() -> WeatherForecastModel {
        return WeatherForecastModel(conditionID: 0, date: Date(), tempHigh: 0, tempLow: 0)
    }
}
