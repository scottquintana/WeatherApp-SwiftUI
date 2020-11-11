//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI

struct WeatherView: View {
    
    @State private var isNight = false
    @ObservedObject private var weatherForecastVM = WeatherForecastVM()
    
    var body: some View {
        ZStack {
            
            BackgroundView(isNight: $isNight)
            
            VStack {
                MainWeatherStatusView(isNight: $isNight)
                
                HStack(spacing: 22) {
                    ForEach(self.weatherForecastVM.forecast.prefix(5), id: \.dt) { forecastVM in
                        WeatherForecastView(dailyWeather: forecastVM)
                    }
                }
                .padding()
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}


struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}


struct MainWeatherStatusView: View {
    
    @ObservedObject private var currentWeatherVM = CurrentWeatherVM()
    @Binding var isNight: Bool
    
    
    var body: some View {
        Text(currentWeatherVM.cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
        
        VStack(spacing: 8) {
            Image(systemName: isNight ? "moon.stars.fill" : currentWeatherVM.conditionId)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(currentWeatherVM.currentTempString + "°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 40)
    }
}


struct WeatherForecastView: View {
    
    private var forecastDayVM: ForecastDayVM
    
    init(dailyWeather: DailyForecastList) {
        self.forecastDayVM = ForecastDayVM(dailyForecast: dailyWeather)
    }
    
    var body: some View {
        VStack {
            Text(forecastDayVM.dayOfWeek)
                .font(.system(size: 18, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: forecastDayVM.conditionId)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(forecastDayVM.dailyHighString + "°")
                .font(.system(size: 24, weight: .medium, design: .default))
                .foregroundColor(.white)
            Text(forecastDayVM.dailyLowString + "°")
                .font(.system(size: 24, weight: .medium, design: .default))
                .foregroundColor(.white)
            
        }
    }
}

