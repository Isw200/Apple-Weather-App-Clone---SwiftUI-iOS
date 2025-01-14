//
//  InternetUnavailableView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-03.
//

import SwiftUI

struct InternetUnavailableView: View {
    @StateObject var mapVM : MapViewModel
    var body: some View {
        VStack {
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .white)
                .frame(width: 65, height: 60)
                .symbolEffect(.wiggle, options: .speed(0.1))
            Text("No Internet Connection")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("Please check your internet settings and try again.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                mapVM.setupNetworkMonitor()
            }) {
                HStack{
                    Image(systemName: "arrow.2.circlepath")
                    Text("Retry")
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
    InternetUnavailableView(mapVM: MapViewModel())
}
