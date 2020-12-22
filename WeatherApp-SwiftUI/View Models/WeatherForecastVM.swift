//
//  WeatherForecastVM.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

//import SwiftUI
//import Combine
//
//
//class WeatherForecastVM: ObservableObject {
//    
//    @Published var forecast = [DailyForecastList]()
//    @ObservedObject var locationManager = LocationManager()
//    
//    private var cancellableNetwork: AnyCancellable?
//    private var cancellableLocation: AnyCancellable?
//    
//    
//    init() {
//        cancellableLocation = locationManager.objectWillChange
//            .sink { _ in self.getCurrentForecast() }
//    }
//    
//    
//    func getCurrentForecast() {
//        self.cancellableNetwork = NetworkManager.shared.getForecastByLocation(lat: locationManager.userLatitude, long: locationManager.userLongitude)
//            .sink(receiveCompletion: { _ in }, receiveValue: { forecast in
//                self.forecast = forecast.daily
//            })
//    }
//}
