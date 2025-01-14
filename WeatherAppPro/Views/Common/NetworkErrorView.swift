//
//  NetworkErrorView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-07.
//

import SwiftUI

struct NetworkErrorView: View {
    @Environment(\.dismiss) var dismiss
    
    func openMailClient() {
        let email = "support@weatherapppro.com"
        if let mailURL = URL(string: "mailto:\(email)"),
           UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL)
        } else {
            print("Unable to open mail app.")
        }
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "network.slash")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .white)
                .frame(width: 65, height: 65)
                .symbolEffect(.wiggle, options: .speed(0.1))
            
            Text("Something went wrong")
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text("Please check your connection and try again. If the issue persists, please contact us at support@weatherapppro.com")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 1)
            
            Button(action: {
                openMailClient()
            }) {
                HStack{
                    Text("Contact Support")
                }
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(100)
            }
            .padding(.top, 40)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

#Preview {
    NetworkErrorView()
}
