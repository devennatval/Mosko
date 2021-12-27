//
//  APIRequest.swift
//  mosko
//
//  Created by Deven Nathanael on 19/12/21.
//

import Foundation
import CoreLocation

class APIRequest: NSObject {
    static func fetchWeather(
        coordinate: CLLocationCoordinate2D,
        successCompletion: @escaping (FetchedData) -> Void,
        failCompletion: @escaping (String) -> Void
    ) {
        BaseRequest.GET(url: Constant.GET_WEATHER_GEO(coordinate: coordinate)) {
            response in
            print(response)
            var dataModel: FetchedData!
            
            do {
                let quarantineModel = try JSONDecoder().decode(FetchedData.self, from: response as! Data)
                dataModel = quarantineModel
                successCompletion(dataModel!)
            } catch let error {
                print("Error reading json file content: \(error.localizedDescription)")
            }
        }
    }
    
    static func fetchWeather(
        cityName: String,
        successCompletion: @escaping (FetchedData) -> Void,
        failCompletion: @escaping (String) -> Void
    ) {
        BaseRequest.GET(url: Constant.GET_WEATHER_CITY(name: cityName)) { response in
            print(response)
            var dataModel: FetchedData!
            
            do {
                let quarantineModel = try JSONDecoder().decode(FetchedData.self, from: response as! Data)
                dataModel = quarantineModel
                successCompletion(dataModel!)
            } catch let error {
                print("Error reading json file content: \(error.localizedDescription)")
            }
        }
    }
}
