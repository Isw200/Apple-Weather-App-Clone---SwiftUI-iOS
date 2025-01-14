//
//  LocationsCurrentWeatherTopView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import SwiftUI

struct LocationsCurrentWeatherTopView: View {
    let name: String
    let temperature: Double
    let weatherDescription: String
    let highTemperature: Double
    let lowTemperature: Double
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(name)")
                .font(.system(size: 40))
            Text("\(temperature, specifier: "%.0f")°")
                .font(.system(size: 84,weight: .light))
            Text("\(capitalizeFirstLetter(weatherDescription))")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.secondary)
                .padding(.bottom, 1)
            HStack {
                Text("H: \(highTemperature, specifier: "%.0f")°")
                Text("L: \(lowTemperature, specifier: "%.0f")°")
            }
            .font(.system(size: 18, weight: .medium))
        }
        .foregroundStyle(.white)
        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 0)
    }
}

#Preview {
    LocationsCurrentWeatherTopView(name: "London", temperature: 20.0, weatherDescription: "Mostly Cloudy", highTemperature: 28.0, lowTemperature: 19.0)
}
