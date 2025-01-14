//
//  HourlyView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct HourlyView: View {
    let data : [HourlyWeatherModel]
    @Binding var darkMode : Bool
    
    private func getInsight(data: [HourlyWeatherModel]) -> String {
        guard !data.isEmpty else {
            return "No data available. Please check again later."
        }
        
        let nextTwelveHours = Array(data.prefix(12))
        
        let rainHours = nextTwelveHours.filter { hour in
            hour.main.lowercased() == "rain"
        }
        let hasRain = !rainHours.isEmpty
        
        let maxPop = nextTwelveHours.map { $0.pop }.max() ?? 0
        
        let averageWindSpeed = nextTwelveHours
            .map { $0.windSpeed }
            .reduce(0, +) / Double(nextTwelveHours.count)

        let averageClouds = nextTwelveHours
            .map { Double($0.clouds) }
            .reduce(0, +) / Double(nextTwelveHours.count)
        
        var conditionsText = ""

        if hasRain || maxPop > 0.5 {
            conditionsText += "Rain is likely throughout the day. "
        } else {
            switch averageClouds {
            case 0..<30:
                conditionsText += "Sunny conditions will continue all day. "
            case 30..<70:
                conditionsText += "Skies will be partly cloudy with occasional sunshine. "
            default:
                conditionsText += "Expect mostly cloudy conditions. "
            }
        }
        
        switch averageWindSpeed {
        case 0..<3:
            conditionsText += "Winds will be calm and barely noticeable."
        case 3..<6:
            conditionsText += "Winds will be light and steady."
        case 6..<10:
            conditionsText += "A gentle breeze will be present, so dress accordingly."
        default:
            conditionsText += "Brisk winds are expected, so hold onto your hat!"
        }
        
        return conditionsText
    }

    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text(getInsight(data: data))
                    .font(.system(size: 15))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.leading)
                
                Divider()
                    .padding(.vertical, 5)
                if data != [] {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 26) {
                            ForEach(data, id: \.self) { item in
                                HourlyViewItem(weatherData: item)
                            }
                        }
                    }
                } else {
                    SkeletonView()
                        .frame(height: 100)
                }
            }
            .padding()
            .background(
                ZStack {
                    BlurView(darkMode: $darkMode)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
            )
            
            Spacer()
        }
    }
}

#Preview {
    HourlyView(data: dummyHourlyWeatherDummyData, darkMode: .constant(true))
}
