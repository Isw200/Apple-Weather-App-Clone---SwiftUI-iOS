//
//  TenDayRowItem.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct TenDayRowItem: View {
    @State var data: DailyWeatherModel
    @State var tempNow: Double
    @State var minTempOfWeek: Double
    @State var maxTempOfWeek: Double
    @State var isFirst: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(sliceDayIntoThreeLetters(day: data.day))")
                .frame(width: 65, alignment: .leading)
            
            Image(systemName: getSfSymbol(strIcon: data.weatherIcon))
                .symbolRenderingMode(.multicolor)
            
            HStack (alignment: .center) {
                Text("\(data.minTemperature, specifier: "%.0f")°")
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(minWidth:35, alignment: .trailing)
                
                TemperatureRangeBarView(minTemp: data.minTemperature, maxTemp: data.maxTemperature, minTempOfWeek: minTempOfWeek, maxTempOfWeek: maxTempOfWeek, isFirst: isFirst, tempNow: tempNow)
                    .padding(.horizontal, 5)
                
                Text("\(data.maxTemperature, specifier: "%.0f")°")
                    .frame(minWidth:35, alignment: .leading)
            }
        }
        .font(.system(size: 20, weight: .medium))
        .foregroundStyle(.white)
    }
}

#Preview {
    TenDayRowItem(data: DailyWeatherModel(from: dummyDailyWeatherData), tempNow: 5.0, minTempOfWeek: 1.0, maxTempOfWeek: 14.0, isFirst: true)
}
