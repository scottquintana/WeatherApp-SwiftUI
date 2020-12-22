//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Scott Quintana on 12/16/20.
//

import WidgetKit
import SwiftUI
import CoreLocation
import Combine

struct Provider: TimelineProvider {
    let widgetViewModel = WidgetViewModel()
    var widgetLocationManager = WidgetLocationManager()
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: WidgetWeather(city: "Nowhere", temp: "66", feelsLike: "66", currentDate: Date()))
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(date: Date(), weather: WidgetWeather(city: "Nowhere", temp: "69", feelsLike: "66", currentDate: Date()))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let currentDate = Date()
        guard let refreshTime = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate) else { return }
        
        widgetLocationManager.fetchLocation(handler: { location in
            
            widgetViewModel.getWidgetWeather(userLocation: location) { weatherData in
                let currentWeather = WidgetWeather(city: "City Name",
                                                   temp: String(format: "%.0f", weatherData.current.temp),
                                                   feelsLike: String(format: "%.0f", weatherData.current.feelsLike), currentDate: weatherData.current.dt)
                let entry = WeatherEntry(date: currentDate, weather: currentWeather)
                let timeline = (Timeline(entries: [entry], policy: .after(refreshTime)))
                completion(timeline)
                
            }
            
        })
        
       
    }
}

struct WidgetWeather {
    let city: String?
    let temp: String
    let feelsLike: String
    let currentDate: Date
}


final class WidgetViewModel {
    private var subscriptions = Set<AnyCancellable>()
    
    var locationName: String?
    
    func getWidgetWeather(userLocation: CLLocation, completion: @escaping (WeatherData) -> Void) {
        
        
        
        getPlace(for: userLocation) { [weak self] placemark in
            guard let self = self else { return }
            guard let placemark = placemark else { return }
            
            var output = ""
            
            if let town = placemark.locality {
                output = output + "\(town)"
            }
            
            if let state = placemark.administrativeArea {
                output = output + ", \(state)"
            }

            self.locationName = output
           
        }
        
        NetworkManager.shared.getWeatherByLocation(lat: userLocation.coordinate.latitude, long: userLocation.coordinate.longitude)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { weather in
                    var currentWeather = weather
//                    currentWeather.cityName = self.locationName
                   completion(currentWeather)
                  })
            .store(in: &subscriptions)
    }
    
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let weather: WidgetWeather
}

struct WeatherWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    let date: Date
    var entry: Provider.Entry

    var body: some View {
        
        if widgetFamily == .systemSmall {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(entry.weather.city ?? "Location unknown")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 14)
                    
                    Text(entry.weather.temp + "°")
                        .font(.system(size: 42, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Feels like: \(entry.weather.feelsLike)°")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding()
            
                }
            }
        } else {
            Text("This is a medium widget")
        }

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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

//struct WeatherWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherWidgetEntryView(entry: WidgetModel(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
