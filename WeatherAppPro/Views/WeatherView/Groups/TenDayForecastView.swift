//
//  TenDayForecastView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct TenDayForecastView: View {
    let tenDayWetherData: [DailyWeatherModel]
    let tempNow: Double
    @Binding var darkMode : Bool
    
    private func getMinTempOfWeek() -> Double {
        var min = 800.0
        for dailyWeather in tenDayWetherData {
            if min > dailyWeather.minTemperature {
                min = dailyWeather.minTemperature
            }
        }
        return min
    }
    
    private func getMaxTempOfWeek() -> Double {
        var max = -100.0
        for dailyWeather in tenDayWetherData {
            if max < dailyWeather.maxTemperature {
                max = dailyWeather.maxTemperature
            }
        }
        return max
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                Text("10-DAY FORECAST")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            if tenDayWetherData != [] {
                ForEach (tenDayWetherData, id: \.self) { dailyWeather in
                    let isFirst = dailyWeather == tenDayWetherData.first
                    Divider()
                        .padding(.bottom, 4)
                    TenDayRowItem(data: dailyWeather, tempNow: tempNow, minTempOfWeek: getMinTempOfWeek(), maxTempOfWeek: getMaxTempOfWeek(), isFirst: isFirst)
                }
            } else {
                ForEach (1..<10) { _ in
                    SkeletonView()
                        .frame(height: 50)
                }
            }
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
    TenDayForecastView(tenDayWetherData: dummyTenDayWeatherDummyData, tempNow: 8.0, darkMode: .constant(true))
}
