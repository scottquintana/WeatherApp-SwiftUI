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

struct WeatherEntry: TimelineEntry {
    let date: Date
    let weather: WidgetWeatherModel
}

struct WeatherWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    var entry: WidgetProvider.Entry
    
    var body: some View {
        
        if widgetFamily == .systemSmall {
            ZStack {
                WidgetBackground()
                VStack {
                    Text(entry.weather.desc)
                        .font(.system(size: 14, weight: .thin, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 14)
                    
                    Text(entry.weather.temp + "°")
                        .font(.system(size: 40, weight: .thin, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Feels like: \(entry.weather.feelsLike)°")
                        .font(.system(size: 14, weight: .thin, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                }
            }
        } else if widgetFamily == .systemMedium {
            ZStack {
                WidgetBackground()
                
                VStack {
                   
                    HStack {
                        
                        HStack {
                            Image(systemName: WeatherConditionHelper.getImageFromConditionId(conditionId: entry.weather.conditionId))
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            VStack(alignment: .leading, spacing: -6.0) {
                                
                                Text(entry.weather.desc)
                                    .font(.system(size: 14, weight: .thin, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("\(entry.weather.temp)°")
                                    .font(.system(size: 46, weight: .thin, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("Feels like: \(entry.weather.feelsLike)°")
                                    .font(.system(size: 12, weight: .thin, design: .rounded))
                                    .foregroundColor(.white)
                                
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 2.0) {
                            Text(DateHelper.convertToLongDay(entry.weather.currentDate))
                                .font(.system(size: 14, weight: .thin, design: .rounded))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing)
                            HStack(spacing: 4.0) {
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10, height: 10)
                                
                                Text(entry.weather.city ?? "Location unknown")
                                    .font(.system(size: 14, weight: .thin, design: .default))
                                    .foregroundColor(.white)
                                
                                
                            }
                            .padding(.trailing)
                        }
                        
                    }
                    .padding([.top, .leading], 10.0)
                    
                    Capsule()
                        .padding(.horizontal)
                        .frame(height: 1.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .opacity(/*@START_MENU_TOKEN@*/0.4/*@END_MENU_TOKEN@*/)
                    
                    HStack{
                        ForEach(entry.weather.hourlyForecast.prefix(6), id: \.dt) { hourlyWeather in
                            HourlyForecastView(hourlyWeather: hourlyWeather)
                        }
                    }
                    .padding([.leading, .bottom, .trailing], 10.0)
                }
                .padding(.vertical, 10.0)
            }
        }
        
    }
    
}

@main
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("WeatherWidget")
        .description("A weather widget!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct WidgetBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherWidgetEntryView(entry: WeatherEntry(date: Date(), weather: .previewData))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            WeatherWidgetEntryView(entry: WeatherEntry(date: Date(), weather: .previewData))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        }
    }
}
