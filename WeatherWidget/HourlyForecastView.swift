//
//  HourlyForecastView.swift
//  WeatherWidgetExtension
//
//  Created by Scott Quintana on 12/23/20.
//

import SwiftUI

struct HourlyForecastView: View {
    
    let hourlyForecastVM: HourlyForecastVM
    
    init(hourlyWeather: HourlyWeather) {
        self.hourlyForecastVM = HourlyForecastVM(hourlyForecast: hourlyWeather)
    }
    
    var body: some View {
        VStack(spacing: 4.0) {
            Text(hourlyForecastVM.temp)
                .font(.system(size: 14, weight: .thin, design: .rounded))
                .foregroundColor(.white)
            Image(systemName: hourlyForecastVM.conditionId)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
            Text(hourlyForecastVM.time)
                .font(.system(size: 10, weight: .thin, design: .rounded))
                .foregroundColor(.white)
        }
        
    }
}
