//
//  ForecastDayVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

import SwiftUI

struct ForecastDayVM {
    let dailyForecast: DailyForecastList
    
    var dayOfWeek: String {
        return DateHelper.convertToShortDay(dailyForecast.dt)
    }
    
    var conditionId: Int {
        return dailyForecast.weather[0].id
    }
    
    var dailyHighString: String {
        return String(format: "%.0f", dailyForecast.temp.max)
    }
    
    var dailyLowString: String {
        return String(format: "%.0f", dailyForecast.temp.min)
    }
}
