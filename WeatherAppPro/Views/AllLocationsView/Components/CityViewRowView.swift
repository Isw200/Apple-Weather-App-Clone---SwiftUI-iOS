//
//  CityViewRowView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-18.
//

import SwiftUI

struct CityViewRowView: View {
    var city: CityModel
    @ObservedObject var citiesVM : CitiesViewModel
    
    var body: some View {
        VStack {
            ZStack {
                VideoBackgroundContainer(weatherCode: city.cityWeather?.weatherType ?? 0, timeZoneOffset: city.timeZoneOffset)
                
                VStack (alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(city.name)
                                .font(.system(size: 26, weight: .bold))
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 0)
                            
                            HStack {
                                if let userCity = citiesVM.userCity {
                                    if userCity.id == city.id {
                                        Text("My Location .")
                                            .font(.system(size: 14, weight: .semibold))
                                        Image(systemName: "house.fill")
                                            .font(.system(size: 12, weight: .semibold))
                                        Text("Home")
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                    } else {
                                        Text("\(getCurrentTime(timeZoneOffset: city.timeZoneOffset, format: "time12h"))")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                } else {
                                    Text("\(getCurrentTime(timeZoneOffset: city.timeZoneOffset, format: "time12h"))")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                            }
                        }
                        
                        Spacer()
                        
                        if (city.cityWeather?.temp == nil) {
                            SkeletonView(cornerRadius: 5)
                                .frame(width: 60, height: 60)
                        } else {
                            Text("\(city.cityWeather?.temp ?? 0, specifier: "%.0f")°")
                                .font(.system(size: 54, weight: .light))
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 0)
                        }
                    }
                    
                    HStack {
                        if (city.cityWeather?.description == nil) {
                            SkeletonView(cornerRadius: 5)
                                .frame(width: 120, height: 20)
                        } else {
                            Text("\(capitalizeFirstLetter(city.cityWeather?.description ?? "Sample Description"))")
                                .font(.system(size: 14, weight: .medium))
                        }
                        
                        Spacer()
                        
                        HStack {
                            if (city.isLoading) {
                                SkeletonView(cornerRadius: 5)
                                    .frame(width: 70, height: 20)
                            } else {
                                Text("H:\(city.cityWeather?.maxTemp ?? 0, specifier: "%.0f")°")
                                Text("L:\(city.cityWeather?.minTemp ?? 0, specifier: "%.0f")°")
                            }
                        }
                        .font(.system(size: 14, weight: .medium))
                    }
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 15)
            }
            .frame(height: 120)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    CityViewRowView(city: londonCity, citiesVM: CitiesViewModel())
}

