//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI

struct WeatherView: View {
    
    @State var isNight = false
    @StateObject var currentWeatherVM = CurrentWeatherVM()

    var body: some View {
        
        ZStack {
            
            BackgroundView(isNight: $isNight)
            
            VStack {
                MainWeatherStatusView(currentWeatherVM: currentWeatherVM, isNight: $isNight)
                
                
                ZStack{
                    HStack {
                        Spacer()
                    }
                    Color(.black)
                        .opacity(0.4)
                        .cornerRadius(26)
                    HStack(spacing: 22) {
                        ForEach(self.currentWeatherVM.currentForecast.prefix(5), id: \.dt) { forecastVM in
                            WeatherForecastView(dailyWeather: forecastVM)
                        }
                    }
                }
                Spacer()
            }
            
            .padding(.horizontal, 30)
            
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
    
    var currentWeatherVM: CurrentWeatherVM
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
            VStack(spacing: 8) {
                HStack(spacing: 22) {
                    DetailText("Feels like:")
                    Spacer()
                    DetailText(currentWeatherVM.feelsLike + "°")
                }
                HStack(spacing: 22) {
                    DetailText("Wind:")
                    Spacer()
                    DetailText(currentWeatherVM.wind)
                }
                HStack(spacing: 22) {
                    DetailText("Humidity:")
                    Spacer()
                    DetailText(currentWeatherVM.humidity)
                }
                HStack(spacing: 22) {
                    DetailText("Sunrise:")
                    Spacer()
                    DetailText(DateHelper.convertToTimeFormat(currentWeatherVM.sunriseTime))
                }
                HStack(spacing: 22) {
                    DetailText("Sunset:")
                    Spacer()
                    DetailText(DateHelper.convertToTimeFormat(currentWeatherVM.sunsetTime))
                }
               
            }
            .padding(.top, 20)
            
        }.onAppear {
            isNight = !currentWeatherVM.isDaytime
        }
        .padding(.bottom, 40)
    }
}


struct WeatherForecastView: View {
    
    private var forecastDayVM: ForecastDayVM
    
    init(dailyWeather: DailyWeather) {
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
                .foregroundColor(.gray)
        }
    }
}

