//
//  HumidityView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct HumidityView: View {
    let humidity : Int
    let drewPoint : Double
    @Binding var darkMode: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "humidity.fill")
                Text("HUMIDITY")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            HStack{
                Text("\(humidity)%")
                    .font(.system(size: 36))
                    .foregroundStyle(.white)
                    .padding(.top, 6)
                
                Spacer()
            }
            
            Spacer()
            
            Text("The dew point is \(drewPoint, specifier: "%.0f")° right now")
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.top, 20)
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
    HumidityView(humidity: 72, drewPoint: 26.3, darkMode:.constant(true))
}
