//
//  PressureView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct PressureView: View {
    let pressure: Int?
    let minValue: Double = 25.0
    let maxValue: Double = 32.0
    @Binding var darkMode: Bool

    private func convertHpaToInHg(hPa: Int) -> Double {
        return Double(hPa) * 0.02953
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                Text("PRESSURE")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))

            let rawInHgPressure = convertHpaToInHg(hPa: pressure ?? 1003)
            let inHgPressure = min(max(rawInHgPressure, minValue), maxValue)

            Spacer()

            HStack {
                Spacer()

                Gauge(value: inHgPressure, in: minValue...maxValue) {
                    Text("Pressure")
                } currentValueLabel: {
                    VStack {
                        Text("\(inHgPressure, specifier: "%.2f")")
                            .font(.system(size: 10, weight: .semibold))
                        Text("inHg")
                            .font(.system(size: 8))
                    }
                    .foregroundStyle(.white)
                } minimumValueLabel: {
                    Text("Low")
                        .font(.system(size: 7))
                        .foregroundStyle(.white)
                } maximumValueLabel: {
                    Text("High")
                        .font(.system(size: 7))
                        .foregroundStyle(.white)
                }
                .tint(LinearGradient(colors: [.white.opacity(0.4), .white.opacity(0.8)],
                                     startPoint: .leading, endPoint: .trailing))
                .gaugeStyle(.accessoryCircular)
                .scaleEffect(2)
                .offset(x: 0, y: -8)

                Spacer()
            }
        }
        .foregroundStyle(.white)
        .padding()
        .padding(.bottom, 10)
        .background(
            ZStack {
                BlurView(darkMode: $darkMode)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        )
    }
}


#Preview {
    PressureView(pressure: 1013, darkMode: .constant(true))
}
