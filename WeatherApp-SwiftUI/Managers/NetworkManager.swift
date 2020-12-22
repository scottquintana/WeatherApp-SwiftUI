//
//  NetworkManager.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import Foundation
import Combine
import CoreLocation

struct NetworkManager {

    static let shared = NetworkManager()
    
    private var apiKey = "acf3bdefcee3638d485f32e0cb93d5c3"
    
    func getWeatherByLocation(lat: CLLocationDegrees, long: CLLocationDegrees) -> AnyPublisher<WeatherData, Error> {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=imperial") else {
            fatalError("Error locating city")
        }
        
        let decodeStrategy = JSONDecoder()
        decodeStrategy.keyDecodingStrategy = .convertFromSnakeCase
        decodeStrategy.dateDecodingStrategy = .secondsSince1970

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: WeatherData.self, decoder: decodeStrategy)
            .catch { _ in Empty<WeatherData, Error>() }
            .eraseToAnyPublisher()
    }
    
    
//    func getForecastByLocation(lat: CLLocationDegrees, long: CLLocationDegrees) -> AnyPublisher<ForecastData, Error> {
//        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely,hourly,alerts&appid=\(apiKey)&units=imperial") else {
//            fatalError("Error locating city")
//        }
//        
//        var number = 3
//        number += 3
//        let decodeStrategy = JSONDecoder()
//        decodeStrategy.dateDecodingStrategy = .secondsSince1970
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .receive(on: RunLoop.main)
//            .map(\.data)
//            .decode(type: ForecastData.self, decoder: decodeStrategy)
//            .catch { _ in Empty<ForecastData, Error>() }
//            .eraseToAnyPublisher()
//    }
}
