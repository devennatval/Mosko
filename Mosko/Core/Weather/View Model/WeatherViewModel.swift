//
//  WeatherViewModel.swift
//  mosko
//
//  Created by Deven Nathanael on 19/12/21.
//

import Foundation
import CoreLocation
import MapKit

enum FetchWeatherStatus: String {
    case loading, done, error
}

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var fetchStatus: FetchWeatherStatus = .loading
    @Published var tempString = ""
    @Published var iconLink = ""
    
    var locationManager: CLLocationManager?
    
    // MARK: Check the Location Services if it's enabled
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            checkLocationAuthorization()
        } else {
            print("Error: Service Disabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("Location restricted likely due to parental control")
            self.fetchStatus = .error
            
        case .denied:
            print("Permission denied. Please go to settings")
            self.fetchStatus = .error
            
        case .authorizedAlways, .authorizedWhenInUse:
            loadWeather()
            
        @unknown default:
            break
        }
    }
    
    func loadWeather() {
        guard let locationManager = locationManager else {
            return
        }
        self.fetchStatus = .loading
        
        APIRequest.fetchWeather(coordinate: locationManager.location!.coordinate) { data in
            self.updateWeatherData(data)
        } failCompletion: { error in
            print(error)
            self.fetchStatus = .error
        }

    }
    
    func updateWeatherData(_ data: FetchedData) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if NSLocale.autoupdatingCurrent.identifier.hasSuffix("US") {
                self.tempString = "\(data.main.temp)°F"
            } else {
                self.tempString = "\(data.main.temp)°C"
            }
            self.iconLink = "https://openweathermap.org/img/wn/" + "\(data.weather[0].icon)" + "@2x.png"
        }
        self.fetchStatus = .done
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

