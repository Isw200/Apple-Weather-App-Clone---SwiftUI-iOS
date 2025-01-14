//
//  MoonView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct MoonView: View {
    let moonPhase: Double
    let moonset: String
    let moonrise: String
    @Binding var darkMode: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "moonphase.waxing.crescent")
                Text("WAXING CRESCENT")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Moonset")
                            .foregroundStyle(.white)
                        Spacer()
                        Text(moonset)
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                    Divider()
                    HStack {
                        Text("Moonrise")
                            .foregroundStyle(.white)
                        Spacer()
                        Text(moonrise)
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                    Divider()
                    HStack {
                        Text("Moon Phase")
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(moonPhase, specifier: "%.2f")")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }
                .font(.system(size: 16, weight: .medium))
                
                Image("moon")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .opacity(0.6)
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
    MoonView(moonPhase: 0.13, moonset: "06:00 AM", moonrise: "09:00 PM", darkMode: .constant(true))
}
