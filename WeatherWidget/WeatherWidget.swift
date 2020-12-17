//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Scott Quintana on 12/16/20.
//

import WidgetKit
import SwiftUI
import Combine

struct Provider: TimelineProvider {
    let widgetViewModel = WidgetViewModel()
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: WidgetWeather(temp: "66"))
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(date: Date(), weather: WidgetWeather(temp: "69"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let currentDate = Date()
        guard let refreshTime = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate) else { return }
        
        widgetViewModel.getWidgetWeather { weatherData in
            let currentWeather = WidgetWeather(temp: String(format: "%.0f", weatherData.main.temp))
            let entry = WeatherEntry(date: currentDate, weather: currentWeather)
            let timeline = (Timeline(entries: [entry], policy: .after((refreshTime))))
            completion(timeline)
            
        }
    }
}

struct WidgetWeather {
    let temp: String
}

final class WidgetViewModel {
    private var subscriptions = Set<AnyCancellable>()
    
    func getWidgetWeather(completion: @escaping (WeatherData) -> Void) {
        NetworkManager.shared.getWeatherByCity(lat: 0, long: 0)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { weather in
                   completion(weather)
                  })
            .store(in: &subscriptions)
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let weather: WidgetWeather
}

struct WeatherWidgetEntryView : View {
    let date: Date
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
        Text(entry.weather.temp + "°")
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(date: Date(), entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//struct WeatherWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherWidgetEntryView(entry: WidgetModel(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
