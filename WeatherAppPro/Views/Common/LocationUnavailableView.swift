//
//  LocationUnavailableView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-03.
//

import SwiftUI

struct LocationUnavailableView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "location.slash")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .white)
                .frame(width: 65, height: 60)
                .symbolEffect(.wiggle, options: .speed(0.1))
            
            Text("Location Services Disabled")
                .font(.largeTitle)
                .bold()
                .padding()
                .multilineTextAlignment(.center)
            Text("Please enable location services in your device settings.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsURL) {
                        UIApplication.shared.open(settingsURL)
                    }
            }) {
                HStack{
                    Image(systemName: "gearshape")
                    Text("Open Settings")
                }
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(100)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

#Preview {
    LocationUnavailableView()
}
