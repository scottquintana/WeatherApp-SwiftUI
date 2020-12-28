//
//  HourlyForecastVM.swift
//  WeatherWidgetExtension
//
//  Created by Scott Quintana on 12/23/20.
//

import Foundation

struct HourlyForecastVM {
    let hourlyForecast: HourlyWeather
    
    var conditionId: String {
        return WeatherConditionHelper.getImageFromConditionId(conditionId: hourlyForecast.weather[0].id)
    }
    
    var temp: String {
        let string = String(format: "%.0f", hourlyForecast.temp) + "°"
        return string
    }
    
    var time: String {
        return DateHelper.convertToTimeFormat(hourlyForecast.dt)
    }
    
    
}
