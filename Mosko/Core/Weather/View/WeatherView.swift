//
//  WeatherView.swift
//  mosko
//
//  Created by Deven Nathanael on 19/12/21.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()

    var body: some View {
        switch weatherViewModel.fetchStatus {
        case .loading:
            HStack {
                ProgressView().progressViewStyle(.circular)
                    .onAppear {
                        weatherViewModel.checkLocationEnabled()
                    }
                Spacer()
                Text("Loading")
            }
        case .done:
            HStack {
                AsyncImage(url: URL(string: weatherViewModel.iconLink)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                
                Text(weatherViewModel.tempString)
            }
        case .error:
            Text("-.- °C")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
