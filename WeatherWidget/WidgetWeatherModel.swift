//
//  WidgetWeatherModel.swift
//  WeatherWidgetExtension
//
//  Created by Scott Quintana on 12/23/20.
//

import Foundation

struct WidgetWeatherModel {

    let city: String?
    let temp: String
    let feelsLike: String
    let conditionId: Int
    let currentDate: Date
    let desc: String
    let hourlyForecast: [HourlyWeather]
    let isNight: Bool
}

extension WidgetWeatherModel {
    static let previewData = WidgetWeatherModel(
        city: "Any City",
        temp: "66",
        feelsLike: "62",
        conditionId: 800,
        currentDate: Date(),
        desc: "Sunny",
        hourlyForecast: [],
        isNight: false
    )
}
