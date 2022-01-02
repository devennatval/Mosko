//
//  Temperature.swift
//  mosko
//
//  Created by Deven Nathanael on 11/12/21.
//

import Foundation
import Charts

struct Temperature: Encodable, Decodable {
    var date: Date
    var hour: Int
    var minute: Int
    var temperature: Double
    
    static func dataEntriesForHour(temperature: [Temperature]) -> [ChartDataEntry] {
        let calendar = Calendar.current
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date()) ?? Date()
        var minuteTemperature = temperature.filter{$0.date > hourAgo}
        minuteTemperature.sort { $0.date < $1.date}
        return minuteTemperature.map{
            ChartDataEntry(x: $0.date.timeIntervalSince1970 , y: $0.temperature)
        }
    }
    static func dataEntriesForDay(temperature: [Temperature]) -> [ChartDataEntry] {
        let calendar = Calendar.current
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        var minuteTemperature = temperature.filter{$0.date > dayAgo && ($0.minute == 0 || $0.minute == 30)}
        minuteTemperature.sort { $0.date < $1.date}
        return minuteTemperature.map{
            ChartDataEntry(x: $0.date.timeIntervalSince1970 , y: $0.temperature)
        }
    }
}
