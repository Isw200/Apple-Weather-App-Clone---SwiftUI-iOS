//
//  FeelsLike.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct FeelsLikeView: View {
    let feelsLike: Double
    var actualTemp: Double
    @Binding var darkMode: Bool
    
    private func getInsight() -> String {
        if (feelsLike == 0) {
            return "No data available. Stay Safe!"
        } else {
            return "It feels \(feelsLike > actualTemp ? "warmer" : "cooler") than the actual temperature."
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text("FEEELS LIKE")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            Text("\(feelsLike, specifier: "%.0f")°")
                .font(.system(size: 36))
                .foregroundStyle(.white)
                .padding(.top, 6)
            
            Spacer()
            
            HStack{
                Text(getInsight())
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                
                Spacer()
            }
                
        }
        .frame(minWidth: 0, maxWidth: .infinity)
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
    FeelsLikeView(feelsLike: 33.0, actualTemp: 29.0, darkMode: .constant(false))
}
