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
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let sortTemp = temperature.sorted { $0.date < $1.date}
        let minuteTemperature = sortTemp.filter{$0.date > hourAgo}
        return minuteTemperature.map{
            ChartDataEntry(x: $0.date.timeIntervalSince1970 , y: $0.temperature)
        }
    }
}
