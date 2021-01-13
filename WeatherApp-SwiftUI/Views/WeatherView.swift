//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var currentWeatherVM = CurrentWeatherVM()
    @State var isNight = false
    

    var body: some View {
        
        ZStack {
            
            BackgroundView(isNight: $isNight)
            
            VStack {
                MainWeatherStatusView(currentWeatherVM: self.currentWeatherVM, isNight: $isNight)
                ZStack{
                    HStack {
                        Spacer()
                    }
                    Color(.black)
                        .opacity(0.1)
                        .cornerRadius(26)
                    HStack(spacing: 22) {
                        ForEach(self.currentWeatherVM.currentForecast.prefix(5), id: \.dt) { forecastVM in
                            WeatherForecastView(dailyWeather: forecastVM)
                        }
                    }
                }
                Spacer()
            }
            
            .padding([.leading, .bottom, .trailing], 30)
            
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
    
    @StateObject var currentWeatherVM: CurrentWeatherVM
    @Binding var isNight: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(currentWeatherVM.cityName)
                    .font(.system(size: 32, weight: .thin, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    
                    
                Text(currentWeatherVM.condition)
                    .font(.system(size: 20, weight: .thin, design: .rounded))
                    .foregroundColor(.white)
                    
            }
            Spacer()
            Image(systemName: isNight ? "moon.stars.fill" : currentWeatherVM.conditionId)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70, alignment: .trailing)
        }
        .padding(.top)
        VStack(spacing: 8) {

            
            Text(currentWeatherVM.currentTempString + "°")
                .font(.system(size: 120, weight: .thin, design: .rounded))
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
            
        }.onChange(of: currentWeatherVM.currentTime, perform: { _ in
            isNight = !currentWeatherVM.isNight
        })
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
                .font(.system(size: 18, weight: .thin, design: .rounded))
                .foregroundColor(.white)
            Image(systemName: forecastDayVM.conditionId)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(forecastDayVM.dailyHighString + "°")
                .font(.system(size: 24, weight: .thin, design: .rounded))
                .foregroundColor(.white)
            Text(forecastDayVM.dailyLowString + "°")
                .font(.system(size: 24, weight: .thin, design: .rounded))
                .foregroundColor(Color(.systemGray4))
        }
    }
}

