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
        formatter.dateFormat = "E"
        return formatter
    }()

    static func convertToShortDay(_ date: Date) -> String {
        return shortDay.string(from: date)
    }
}
