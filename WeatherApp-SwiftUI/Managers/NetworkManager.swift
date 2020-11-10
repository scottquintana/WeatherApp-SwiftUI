//
//  NetworkManager.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/9/20.
//

import Foundation
import Combine

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private var apiKey = "acf3bdefcee3638d485f32e0cb93d5c3"
    func getWeatherByCity(city: String) -> AnyPublisher<WeatherData, Error> {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=imperial") else {
            fatalError("Error locating city")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .catch { _ in Empty<WeatherData, Error>() }
            .eraseToAnyPublisher()
    }
}
