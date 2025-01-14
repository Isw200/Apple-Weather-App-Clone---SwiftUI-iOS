//
//  UvIndexView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct UvIndexView: View {
    let uvIndex: Double
    @Binding var darkMode : Bool
    
    private func getUxIndexWord() -> String {
        if uvIndex == 0 {
            return "No data."
        } else if uvIndex < 3 {
            return "Low"
        } else if uvIndex < 6 {
            return "Moderate"
        } else if uvIndex < 8 {
            return "High"
        } else {
            return "Very High"
        }
    }
    
    private func getUvIndexOffset(barWidth: CGFloat) -> CGFloat {
        let maxUVIndex: Double = 11.0
        let clampedUvIndex = min(max(uvIndex, 0), maxUVIndex)
        let position = clampedUvIndex / maxUVIndex
        return CGFloat(position) * barWidth
    }
    
    private func getUvIndexInsight() -> String {
        switch uvIndex {
        case 0:
            return "No data available. Stay safe!"
        case 1..<3:
            return "No protection needed."
        case 3..<6:
            return "Use sunscreen."
        case 6..<8:
            return "Wear a hat, avoid midday sun."
        case 8..<11:
            return "Seek shade, use protection."
        case 11...:
            return "Avoid outdoor exposure."
        default:
            return "Stay safe!"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "sun.max.fill")
                Text("UV INDEX")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            Text("\(uvIndex, specifier: "%.0f")")
                .font(.system(size: 44))
                .foregroundColor(Color.white)
            
            Text(getUxIndexWord())
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color.white)
            
            Gauge(value: uvIndex, in: 0...11) {
            }
            .gaugeStyle(.accessoryLinear)
            .tint(Gradient(colors: [.green, .lightBlue, .yellow, .orange, .red, .purple, .purple]))
            
            Text(getUvIndexInsight())
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.white)
                
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
    UvIndexView(uvIndex: 3, darkMode: .constant(false))
}
