//
//  AverageView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct AverageView: View {
    let maxTempToday: Double
    let dailyWeather: [DailyWeatherModel]
    @Binding var darkMode: Bool
    
    private func getAverageTemperature() -> Double {
        var temperatureSum: Double = 0
        for weather in dailyWeather {
            temperatureSum += weather.maxTemperature
        }
        return temperatureSum / Double(dailyWeather.count)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text("AVERAGE")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            Text("\(maxTempToday > getAverageTemperature() ? "+" : "-")\(maxTempToday - getAverageTemperature(), specifier: "%.0f")°")
                .font(.system(size: 36))
                .foregroundStyle(.white)
            
            Text("\(maxTempToday > getAverageTemperature() ? "above" : "below") average daily high")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            
            HStack {
                Text("Today")
                    .foregroundColor(Color.white.opacity(0.6))
                Spacer()
                Text("H:\(maxTempToday, specifier: "%.0f")°")
                    .foregroundStyle(.white)
            }
            .font(.system(size: 16, weight: .semibold))
            HStack {
                Text("Average")
                    .foregroundColor(Color.white.opacity(0.6))
                Spacer()
                Text("H:\(getAverageTemperature(), specifier: "%.0f")°")
                    .foregroundStyle(.white)
            }
            .font(.system(size: 16, weight: .semibold))
                
        }
        .padding()
        .background(
            ZStack {
                BlurView(darkMode: $darkMode)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        )
    }
}

#Preview {
    AverageView(maxTempToday: 20, dailyWeather: dummyTenDayWeatherDummyData, darkMode: .constant(true))
}
