//
//  AirQulityView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-12.
//

import SwiftUI

struct AirQulityView: View {
    let airQualityData: AirQualityModel
    @Binding var darkMode : Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "aqi.medium")
                Text("Air Quality")
                Spacer()
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            .padding(.bottom, 10)
            
            Text("Current Air Quality: \(airQualityData.airQualityIndex)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.white.opacity(0.6))
            Gauge(value: Double(airQualityData.airQualityIndex), in: 1.0...5.0) {
                Text("What is this gauge")
            } currentValueLabel: {
                Text("\(airQualityData.airQualityIndex)")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("5")
            }
            .padding(.bottom, 10)
            .padding(.top, 5)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            .gaugeStyle(.accessoryLinear)
            .tint(Gradient(colors: [.green, .lightBlue, .yellow, .orange, .red]))
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(airQualityData.components, id: \.self) { component in
                        VStack {
                            Text(component.name)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(!darkMode ? Color.black.opacity(0.6) : Color.white)
                                .padding(.bottom, 5)
                            Text("\(component.value, specifier: "%.2f")")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(!darkMode ? Color.black.opacity(0.4) : Color.white)
                        }
                        .frame(height: 60)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
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
    AirQulityView(airQualityData: AirQualityModel(from: dummyAirQulityResponseDTO), darkMode: .constant(true))
}
