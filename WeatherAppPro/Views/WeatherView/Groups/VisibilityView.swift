//
//  VisibilityView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct VisibilityView: View {
    let visibility: Int
    @Binding var darkMode: Bool
    
    private func visibilityInsight() -> String {
        if visibility < 1000 {
            "Minimal visibility view."
        } else if visibility < 4000 {
            "Partial clear view."
        } else if visibility < 5000 {
            "Clear view."
        } else {
            "Perfect clear view."
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "eye.fill")
                Text("VISIBILITY")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.white.opacity(0.6))
            
            HStack{
                Text("\( Double(visibility) / 1000, specifier: "%.0f") km")
                    .font(.system(size: 36))
                    .foregroundStyle(.white)
                    .padding(.top, 6)
                
                Spacer()
            }
            
            Spacer()
            
            Text(visibilityInsight())
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
    VisibilityView(visibility: 10000, darkMode: .constant(true))
}
