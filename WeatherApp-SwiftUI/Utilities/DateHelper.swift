//
//  DateHelper.swift
//  WeatherApp-SwiftUI
//
//  Created by Scott Quintana on 11/10/20.
//

import Foundation

class DateHelper {
    static var shortDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()

    static func convertToShortDay(_ date: Date) -> String {
        return shortDay.string(from: date)
    }
    
    static var longDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()

    static func convertToLongDay(_ date: Date) -> String {
        return longDay.string(from: date)
    }
    
    static var timeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    static var timeDateFormatter24: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        return formatter
    }()

    static func convertToTimeFormat(_ date: Date) -> String {
        return timeDateFormatter.string(from: date)
    }
    
    static func convertTo24hrTimeFormat(_ date: Date) -> String {
        return timeDateFormatter24.string(from: date)
    }
}
