//
//  CompassView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//
// Referance: https://forums.developer.apple.com/forums/thread/767256

import SwiftUI

struct CompassView: View {
    let windDegrees: Double
    let frameSize: CGFloat
    let windSpeed: Double
    
    var body: some View {
            ZStack {
                Image("compassMarker")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .rotationEffect(Angle(degrees: windDegrees))

                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: frameSize/2, height: frameSize/2)

                VStack {
                    Text("\(windSpeed, specifier: "%.0f")")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)

                    Text("mph")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                }

                ForEach(CompassMarker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker, compassDegress: 0)
                }
            }
            .frame(width: frameSize, height: frameSize)
    }


    struct CompassMarker: Hashable {
        let degrees: Double
        let label: String
        let isSub: Bool

        init(degrees: Double, label: String = "", isSub: Bool = false) {
            self.degrees = degrees
            self.label = label
            self.isSub = isSub
        }

        static func markers() -> [CompassMarker] {
            return [
                CompassMarker(degrees: 0, label: "N"),
                CompassMarker(degrees: 7.5, isSub: true),
                CompassMarker(degrees: 15, isSub: true),
                CompassMarker(degrees: 22.5, isSub: true),
                CompassMarker(degrees: 30),
                CompassMarker(degrees: 37.5, isSub: true),
                CompassMarker(degrees: 45, isSub: true),
                CompassMarker(degrees: 52.5, isSub: true),
                CompassMarker(degrees: 60),
                CompassMarker(degrees: 67.5, isSub: true),
                CompassMarker(degrees: 75, isSub: true),
                CompassMarker(degrees: 82.5, isSub: true),
                CompassMarker(degrees: 90, label: "E"),
                CompassMarker(degrees: 97.5, isSub: true),
                CompassMarker(degrees: 105, isSub: true),
                CompassMarker(degrees: 112.5, isSub: true),
                CompassMarker(degrees: 120),
                CompassMarker(degrees: 127.5, isSub: true),
                CompassMarker(degrees: 135, isSub: true),
                CompassMarker(degrees: 142.5, isSub: true),
                CompassMarker(degrees: 150),
                CompassMarker(degrees: 157.5, isSub: true),
                CompassMarker(degrees: 165, isSub: true),
                CompassMarker(degrees: 172.5, isSub: true),
                CompassMarker(degrees: 180, label: "S"),
                CompassMarker(degrees: 187.5, isSub: true),
                CompassMarker(degrees: 195, isSub: true),
                CompassMarker(degrees: 202.5, isSub: true),
                CompassMarker(degrees: 210),
                CompassMarker(degrees: 217.5, isSub: true),
                CompassMarker(degrees: 225, isSub: true),
                CompassMarker(degrees: 232.5, isSub: true),
                CompassMarker(degrees: 240),
                CompassMarker(degrees: 247.5, isSub: true),
                CompassMarker(degrees: 255, isSub: true),
                CompassMarker(degrees: 262.5, isSub: true),
                CompassMarker(degrees: 270, label: "W"),
                CompassMarker(degrees: 277.5, isSub: true),
                CompassMarker(degrees: 285, isSub: true),
                CompassMarker(degrees: 292.5, isSub: true),
                CompassMarker(degrees: 300),
                CompassMarker(degrees: 307.5, isSub: true),
                CompassMarker(degrees: 315, isSub: true),
                CompassMarker(degrees: 322.5, isSub: true),
                CompassMarker(degrees: 330),
                CompassMarker(degrees: 337.5, isSub: true),
                CompassMarker(degrees: 345, isSub: true),
                CompassMarker(degrees: 352.5, isSub: true)
            ]

        }

        func degreeText() -> String {
            return String(format: "%.0f", self.degrees)
        }
    }

    struct CompassMarkerView: View {
        let marker: CompassMarker
        let compassDegress: Double

        var body: some View {
            VStack {
                if marker.label != "" {
                    Text(marker.label)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(Color.white)
                        .opacity(0.6)
                        .rotationEffect(self.textAngle())
                        .offset(y: -4)
                } else {
                    Capsule()
                        .frame(width: 1.5, height: 8)
                        .foregroundStyle(marker.isSub ? Color.white.opacity(0.4) : Color.white)
                        .opacity(0.6)

                    Text(marker.label)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.white)
                        .opacity(0.6)
                        .rotationEffect(self.textAngle())
                }

                Spacer(minLength: 97)
            }
            .rotationEffect(Angle(degrees: marker.degrees))
        }
        
        private func textAngle() -> Angle {
            return Angle(degrees: -self.compassDegress - self.marker.degrees)
        }
    }
}

#Preview {
    CompassView(windDegrees: 110, frameSize: 240.0, windSpeed: 7.0)
}
