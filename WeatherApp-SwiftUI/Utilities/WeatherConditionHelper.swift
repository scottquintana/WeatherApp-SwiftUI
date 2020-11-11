//
//  WeatherConditionHelper.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/11/20.
//

import Foundation

class WeatherConditionHelper {
    static func getImageFromConditionId(conditionId: Int) -> String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
}
