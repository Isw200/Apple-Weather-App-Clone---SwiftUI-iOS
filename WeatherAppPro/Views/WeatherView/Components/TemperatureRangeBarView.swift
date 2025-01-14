//
//  TemperatureRangeBarView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct TemperatureRangeBarView: View {
    @State var minTemp: Double
    @State var maxTemp: Double
    @State var minTempOfWeek: Double
    @State var maxTempOfWeek: Double
    @State var isFirst: Bool
    @State var tempNow: Double
    
    func isToday(day: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let today = formatter.string(from: Date())
        return day == today
    }
    
    private func getGradientColor(minTemp: Double, maxTemp: Double) -> Gradient {
        var startColor: Color = Color.lightBlue
        var endColor: Color = Color.hotYellow
        
        if minTemp < 9 {
            startColor = Color.lightBlue
        } else {
            startColor = .yellow
        }
        
        if maxTemp > 10 {
            endColor = Color.orange
        } else {
            endColor = Color.hotYellow
        }
        
        return Gradient(colors: [startColor, endColor])
    }

    var body: some View {
        GeometryReader { geometry in
            let totalRange = maxTempOfWeek - minTempOfWeek
            let minTempPosition = (minTemp - minTempOfWeek) / totalRange * geometry.size.width
            let maxTempPosition = (maxTemp - minTempOfWeek) / totalRange * geometry.size.width
            let tempNowPosition = (tempNow - minTempOfWeek) / totalRange * geometry.size.width

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.ultraThinMaterial)
                    .frame(height: 8)
                
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(
                        gradient: getGradientColor(minTemp: minTemp, maxTemp: maxTemp),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: maxTempPosition - minTempPosition, height: 8)
                    .offset(x: minTempPosition)

                if isFirst {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 9, height: 9)
                        .overlay(
                            Circle()
                                .stroke(.ultraThinMaterial, lineWidth: 3)
                        )
                        .offset(x: tempNowPosition - 6)
                }
            }
            .frame(height: 20)
        }
        .frame(height: 20)
    }
}

#Preview {
    TemperatureRangeBarView(
        minTemp: 22.0,
        maxTemp: 26.0,
        minTempOfWeek: 20.0,
        maxTempOfWeek: 28.0,
        isFirst: true,
        tempNow: 23.0
    )
}

