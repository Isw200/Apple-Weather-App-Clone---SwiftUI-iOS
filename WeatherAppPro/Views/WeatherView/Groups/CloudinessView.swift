//
//  CloudinessView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct CloudinessView: View {
    let cloudiness: Int
    let timeZoneOffset: Double
    @Binding var darkMode: Bool
    
    private func getIconName() -> String {
        if cloudiness >= 80 {
            return "cloud.fill"
        } else if cloudiness >= 60 {
            return "cloud.fog.fill"
        } else if cloudiness >= 40 {
            return "cloud.fill"
        } else {
            return isDaytime() ? "cloud.sun.fill" : "cloud.moon.fill"
        }
    }
    
    private func getInsight() -> String {
        if cloudiness >= 80 {
            return "Very Cloudy skies"
        } else if cloudiness >= 60 {
            return "Partly Cloudy"
        } else if cloudiness >= 40 {
            return "Cloudy in some areas"
        } else {
            return isDaytime() ? "Clear sunny skies" : "Clear skies"
        }
    }
    
    private func isDaytime() -> Bool {
        let utcTime = Date()
        let offsetInSeconds = Int(timeZoneOffset * 3600)

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        guard let locationTime = calendar.date(byAdding: .second, value: offsetInSeconds, to: utcTime) else {
            print("Invalid time zone offset")
            return false
        }

        let currentHour = calendar.component(.hour, from: locationTime)
        return currentHour >= 6 && currentHour < 18
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "cloud.fill")
                Text("CLOUDINESS")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            HStack {
                Image(systemName: getIconName())
                    .font(.system(size: 64))
                    .symbolRenderingMode(.multicolor)
                    .padding(.vertical, 5)
                
                Spacer()
            }
            
            Spacer()
            
            Text(getInsight())
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            
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
    CloudinessView(cloudiness: 90, timeZoneOffset: 0, darkMode: .constant(true))
}
