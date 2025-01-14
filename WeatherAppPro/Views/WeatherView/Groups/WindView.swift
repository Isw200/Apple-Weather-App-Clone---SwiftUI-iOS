//
//  WindView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct WindView: View {
    let windSpeed: Double
    let windDirection: Double
    let gustSpeed: Double
    @Binding var darkMode: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "wind")
                Text("WIND")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            HStack {
                VStack (alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Wind")
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(windSpeed, specifier: "%.0f") mph")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Gusts")
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(gustSpeed, specifier: "%.0f") mph")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Direction")
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(windDirection, specifier: "%.0f") \(getWindDirection(windDirection: windDirection))")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }
                .font(.system(size: 16, weight: .medium))
                .padding(.trailing, 10)
                
                Spacer()
                
                CompassView(windDegrees: windDirection, frameSize: 140, windSpeed: windSpeed)
            }
            .padding(.top, 3)
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
    WindView(windSpeed: 7.0, windDirection: 320, gustSpeed: 12.0, darkMode: .constant(true))
}
