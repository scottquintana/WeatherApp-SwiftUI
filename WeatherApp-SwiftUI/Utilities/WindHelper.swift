//
//  WindHelper.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 12/14/20.
//

import Foundation

class WindHelper {
    
    static func windDirection(_ direction: Double) -> String {
        switch direction {
        case 0...22.5:
            return "N"
        case 22.6...67.5:
            return "NE"
        case 67.6...112.5:
            return "E"
        case 112.6...157.5:
            return "SE"
        case 157.6...202.5:
            return "S"
        case 202.6...247.5:
            return "SW"
        case 247.6...292.5:
            return "W"
        case 292.6...337.5:
            return "NW"
        default:
            return "N"
        }
    }
    
}
