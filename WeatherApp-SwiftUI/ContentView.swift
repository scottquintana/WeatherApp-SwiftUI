//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
           
            BackgroundView(isNight: $isNight)
            
            VStack {
                CityTextView(cityName: "Cupertino")
                
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 22) {
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 76)
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 86)
                    WeatherDayView(dayOfWeek: "THU", imageName: "wind", temperature: 68)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.drizzle.fill", temperature: 61)
                    WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.sun.rain.fill", temperature: 55)
                    }
                
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
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 18, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 24, weight: .medium, design: .default))
                .foregroundColor(.white)
            
        }
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

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
    
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 40)
    }
}
