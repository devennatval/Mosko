//
//  Temperature.swift
//  mosko
//
//  Created by Deven Nathanael on 11/12/21.
//

import Foundation
import Charts

struct Temperature {
    var day: Int
    var hour: Double
    var temperature: Double
    
    static func dataEntriesForDay(_ day: Int, temperature: [Temperature]) -> [ChartDataEntry] {
        let dayTemperature = temperature.filter{$0.day == day}
        return dayTemperature.map{ChartDataEntry(x: $0.hour, y: $0.temperature)}
    }
    
    static var temperatureHistory: [Temperature] {
        [
        Temperature(day: 0, hour: 0, temperature: 24),
        Temperature(day: 0, hour: 1, temperature: 24),
        Temperature(day: 0, hour: 2, temperature: 23),
        Temperature(day: 0, hour: 3, temperature: 23.5),
        Temperature(day: 0, hour: 4, temperature: 25),
        Temperature(day: 0, hour: 5, temperature: 24),
        Temperature(day: 0, hour: 6, temperature: 24.5),
        Temperature(day: 0, hour: 7, temperature: 26),
        Temperature(day: 0, hour: 8, temperature: 25),
        Temperature(day: 0, hour: 9, temperature: 25),
        Temperature(day: 0, hour: 10, temperature: 26),
        Temperature(day: 0, hour: 11, temperature: 27),
        Temperature(day: 0, hour: 12, temperature: 26),
        Temperature(day: 0, hour: 13, temperature: 26),
        Temperature(day: 0, hour: 14, temperature: 25),
        Temperature(day: 0, hour: 15, temperature: 25),
        Temperature(day: 0, hour: 16, temperature: 26),
        Temperature(day: 0, hour: 17, temperature: 25),
        Temperature(day: 0, hour: 18, temperature: 27),
        Temperature(day: 0, hour: 19, temperature: 28),
        Temperature(day: 0, hour: 20, temperature: 27),
        Temperature(day: 0, hour: 21, temperature: 26),
        Temperature(day: 0, hour: 22, temperature: 25),
        Temperature(day: 0, hour: 23, temperature: 25),
        Temperature(day: 1, hour: 0, temperature: 24),
        Temperature(day: 1, hour: 1, temperature: 24),
        Temperature(day: 1, hour: 2, temperature: 26),
        Temperature(day: 1, hour: 3, temperature: 25),
        Temperature(day: 1, hour: 4, temperature: 26),
        Temperature(day: 1, hour: 5, temperature: 27),
        Temperature(day: 1, hour: 6, temperature: 28)



        ]
    }
}
