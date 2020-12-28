//
//  WidgetTimeline.swift
//  WeatherWidgetExtension
//
//  Created by Scott Quintana on 12/23/20.
//

import SwiftUI
import WidgetKit

struct WidgetProvider: TimelineProvider {
    let widgetViewModel = WidgetViewModel()
    var widgetLocationManager = WidgetLocationManager()
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: WidgetWeatherModel.previewData)
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(date: Date(), weather: WidgetWeatherModel.previewData)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let currentDate = Date()
        guard let refreshTime = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate) else { return }
        
        widgetLocationManager.fetchLocation(handler: { location in
            
            widgetViewModel.getWidgetWeather(userLocation: location) { weatherData in
                let currentWeather = WidgetWeatherModel(city: weatherData.cityName,
                                                   temp: String(format: "%.0f", weatherData.current.temp),
                                                   feelsLike: String(format: "%.0f", weatherData.current.feelsLike),
                                                   conditionId: weatherData.current.weather[0].id,
                                                   currentDate: weatherData.current.dt,
                                                   desc: weatherData.current.weather[0].main,
                                                   hourlyForecast: weatherData.hourly,
                                                   isNight: !(weatherData.current.dt > weatherData.current.sunrise && weatherData.current.dt < weatherData.current.sunset))
                let entry = WeatherEntry(date: currentDate, weather: currentWeather)
                let timeline = (Timeline(entries: [entry], policy: .after(refreshTime)))
                completion(timeline)
                
            }
            
        })
        
       
    }
}
