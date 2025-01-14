//
//  HourlyViewItem.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct HourlyViewItem: View {
    @State var weatherData: HourlyWeatherModel
    
    func getTime(time: String) -> String {
        let currentTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTimeString = dateFormatter.string(from: currentTime)
        
        return time == currentTimeString ? "Now" : time
    }
    
    var body: some View {
        VStack {
            Text(getTime(time: weatherData.time))
                .font(.system(size: 14, weight: .medium))
            
            Image(systemName: getSfSymbol(strIcon: weatherData.weatherIcon))
                .font(.system(size: 30))
                .padding(.vertical, 2)
                .symbolRenderingMode(.multicolor)
            
            Text("\(weatherData.temp, specifier: "%.0f")°")
                .font(.system(size: 20, weight: .medium))
        }
        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 0)
        .foregroundStyle(Color.white)
    }
}

#Preview {
    HourlyViewItem(weatherData: HourlyWeatherModel(from: dummyHourlyWeatherData))
}
