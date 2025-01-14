//
//  SunsetView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct SunsetView: View {
    @State private var currentTime = Date()
    var sunsetTime: String
    var sunriseTime: String
    @Binding var darkMode : Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "sunset.fill")
                Text("SUNSET")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            Text(sunsetTime)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding(.top, 2)

            GeometryReader { geometry in
                ZStack {
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let midHeight = height / 2
                        
                        path.move(to: CGPoint(x: 0, y: midHeight))
                        
                        path.addCurve(
                            to: CGPoint(x: width, y: midHeight),
                            control1: CGPoint(x: width * 0.25, y: -height * 0.5), control2: CGPoint(x: width * 0.75, y: -height * 0.5)
                        )
                    }
                    .stroke(Color.white.opacity(0.5), lineWidth: 4)
                    
                    let sunPosition = calculateSunPositionOnCurve(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        progress: 0.7
                    )
                    
                    ZStack {
                       if isDayTime() {
                           Circle()
                               .fill(Color.white.opacity(0.3))
                               .frame(width: 30, height: 30)
                               .blur(radius: 4)

                           Circle()
                               .fill(Color.white.opacity(0.5))
                               .frame(width: 20, height: 20)
                               .blur(radius: 3)

                           Circle()
                               .fill(Color.white)
                               .frame(width: 10, height: 10)
                       } else {
                           Circle()
                               .fill(Color.white.opacity(0.5))
                               .frame(width: 20, height: 20)
                               .blur(radius: 3)

                           Circle()
                               .fill(Color.gray)
                               .frame(width: 10, height: 10)
                       }
                   }
                   .position(sunPosition)
                }
            }
            .frame(height: 40)
            .padding(.top, 5)

            Text("Sunrise: \(sunriseTime)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 2)
        }
        .padding()
        .background(
            ZStack {
                BlurView(darkMode: $darkMode)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        )
    }

    private func calculateSunPositionOnCurve(width: CGFloat, height: CGFloat, progress: CGFloat) -> CGPoint {
        let midHeight = height / 2

        let startPoint = CGPoint(x: 0, y: midHeight)
        let control1 = CGPoint(x: width * 0.25, y: -height * 0.5)
        let control2 = CGPoint(x: width * 0.75, y: -height * 0.5)
        let endPoint = CGPoint(x: width, y: midHeight)

        let t = progress
        let oneMinusT = 1.0 - t

        let x = oneMinusT * oneMinusT * oneMinusT * startPoint.x +
                3 * oneMinusT * oneMinusT * t * control1.x +
                3 * oneMinusT * t * t * control2.x +
                t * t * t * endPoint.x

        let y = oneMinusT * oneMinusT * oneMinusT * startPoint.y +
                3 * oneMinusT * oneMinusT * t * control1.y +
                3 * oneMinusT * t * t * control2.y +
                t * t * t * endPoint.y

        return CGPoint(x: x, y: y)
    }
    
    private func isDayTime() -> Bool {
        let sunrise = timeToMinutes(sunriseTime)
        let sunset = timeToMinutes(sunsetTime)
        let current = timeToMinutes(DateFormatter.localizedString(from: currentTime, dateStyle: .none, timeStyle: .short))
        return current >= sunrise && current <= sunset
    }
    
    private func timeToMinutes(_ time: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        guard let date = formatter.date(from: time) else { return 0 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        return (components.hour ?? 0) * 60 + (components.minute ?? 0)
    }
}

#Preview {
    SunsetView(sunsetTime: "5:33PM", sunriseTime:"6:09AM", darkMode: .constant(true))
}
