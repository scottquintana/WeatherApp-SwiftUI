//
//  WeatherForecastVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

import Foundation
import Combine


class WeatherForecastVM: ObservableObject {
    
    @Published var forecast = [DailyForecastList]()
    private var locationViewModel = LocationViewModel()
    private var cancellable: AnyCancellable?
    
   
        
    init() {
        getCurrentForecast()
        print("initialized")
    }
    
    func getCurrentForecast() {
        print(locationViewModel.userLatitude)
        self.cancellable = NetworkManager.shared.getForecastByLocation(lat: locationViewModel.userLatitude, long: locationViewModel.userLongitude)
            .sink(receiveCompletion: { x in print(x) }, receiveValue: { forecast in
                print("test")
                self.forecast = forecast.daily
            })
        }
}
