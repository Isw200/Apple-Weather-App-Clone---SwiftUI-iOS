//
//  PrecipitationView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-21.
//

import SwiftUI
import MapKit

struct PrecipitationView: View {
    @Binding var selectedCity: CityModel
    let precipitation: Double
    @Binding var darkMode: Bool

    @State private var mapPosition: MapCameraPosition = .automatic

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "umbrella.fill")
                Text("PERCIPITATION")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            Map(position: $mapPosition) {
                Annotation("\(selectedCity.name)", coordinate: CLLocationCoordinate2D(latitude: selectedCity.lat, longitude: selectedCity.lon)) {
                    ZStack {
                        VStack{}
                            .frame(width: 56, height: 56)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(Circle())
                        
                        VStack(spacing: 0) {
                            Image(systemName: precipitation > 0.5 ? "cloud.rain.fill" : "sun.max.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(precipitation > 0.5 ? .blue : .yellow)
                            
                            Text("\(precipitation > 0 ? Int(precipitation * 100) : 0)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.black)
                                .padding(4)
                                .cornerRadius(8)
                        }
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                    }
                }
            }
            .onAppear {
                mapPosition = .region(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: selectedCity.lat, longitude: selectedCity.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                ))
            }
            .allowsHitTesting(false)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(height: 250)
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
    PrecipitationView(selectedCity: .constant(londonCity), precipitation: 0.7, darkMode: .constant(true))
}

