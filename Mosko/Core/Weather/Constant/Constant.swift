//
//  Constant.swift
//  mosko
//
//  Created by Deven Nathanael on 19/12/21.
//

import Foundation
import CoreLocation

class Constant: NSObject {
    static func GET_WEATHER_CITY(
        name: String,
        apiKey: String = "600486337b93a64cc8f9a103cb4f49fe"
    ) -> String {
        if NSLocale.autoupdatingCurrent.identifier.hasSuffix("US") {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=imperial&appid=\(apiKey)"
        } else {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=metric&appid=\(apiKey)"
        }
    }
    
    static func GET_WEATHER_GEO(
        coordinate: CLLocationCoordinate2D,
        apiKey: String = "600486337b93a64cc8f9a103cb4f49fe"
    ) -> String {
        if NSLocale.autoupdatingCurrent.identifier.hasSuffix("US") {
            return "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=imperial&appid=\(apiKey)"
        } else {
            return "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=metric&appid=\(apiKey)"
        }
    }
}
