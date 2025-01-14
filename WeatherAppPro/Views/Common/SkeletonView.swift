//
//  SkeletonView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-19.
//

import SwiftUI

struct SkeletonView: View {
    var cornerRadius: CGFloat = 10
    var animation: Animation = Animation.linear(duration: 1.0).repeatForever(autoreverses: false)
    
    @State private var gradientOffset: CGFloat = -1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white.opacity(0.1))
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.05),
                        Color.white.opacity(0),
                        Color.white.opacity(0.05)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                )
                .offset(x: gradientOffset * geometry.size.width)
                .onAppear {
                    withAnimation(animation) {
                        gradientOffset = 1.5
                    }
                }
            }
        }
        .clipped()
    }
}

#Preview {
    SkeletonView()
}
