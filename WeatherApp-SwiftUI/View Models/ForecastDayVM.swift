//
//  ForecastDayVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

import Foundation

struct ForecastDayVM {
    let dailyForecast: DailyWeather
    
    var dayOfWeek: String {
        return DateHelper.convertToShortDay(dailyForecast.dt)
    }
    
    var conditionId: String {
        return WeatherConditionHelper.getImageFromConditionId(conditionId: dailyForecast.weather[0].id)
    }
    
    var dailyHighString: String {
        return String(format: "%.0f", dailyForecast.temp.max)
    }
    
    var dailyLowString: String {
        return String(format: "%.0f", dailyForecast.temp.min)
    }
}
