//
//  HomeView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var weatherVM: WeatherViewModel = WeatherViewModel()
    @State var city: CityModel
    @Binding var units: WeatherUnit
    @Binding var darkMode: Bool
    
    var body: some View {
        ZStack {
            VideoBackgroundContainer(weatherCode: weatherVM.currentWeather?.weatherType ?? 0, timeZoneOffset: city.timeZoneOffset)
            
            ScrollView(showsIndicators: false) {
                LocationsCurrentWeatherTopView(
                    name: city.name,
                    temperature: weatherVM.currentWeather?.temp ?? 0,
                    weatherDescription: weatherVM.currentWeather?.weatherDescription ?? "",
                    highTemperature: weatherVM.dailyWeather.first?.maxTemperature ?? 0,
                    lowTemperature: weatherVM.dailyWeather.first?.minTemperature ?? 0
                )
                .padding(.top, 100)
                .padding(.bottom, 50)
                
                HourlyView(data: weatherVM.hourlyWeather, darkMode: $darkMode)
                
                TenDayForecastView(tenDayWetherData: weatherVM.dailyWeather, tempNow: weatherVM.currentWeather?.temp ?? 0, darkMode: $darkMode)
                
                PrecipitationView(selectedCity: $city, precipitation: weatherVM.dailyWeather.first?.pop ?? 0, darkMode: $darkMode)
                    .edgesIgnoringSafeArea(.all)
                
                Grid {
                    GridRow {
                        AverageView(
                            maxTempToday: weatherVM.dailyWeather.first?.maxTemperature ?? 0,
                            dailyWeather: weatherVM.dailyWeather,
                            darkMode: $darkMode
                        )
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        FeelsLikeView(
                            feelsLike: weatherVM.currentWeather?.feelsLike ?? 0,
                            actualTemp: weatherVM.currentWeather?.temp ?? 0,
                            darkMode: $darkMode
                        )
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                
                WindView(windSpeed: weatherVM.currentWeather?.windSpeed ?? 0, windDirection: Double(weatherVM.currentWeather?.windDeg ?? 0), gustSpeed: weatherVM.currentWeather?.windGust ?? 0, darkMode: $darkMode)
                
                Grid {
                    GridRow {
                        UvIndexView(uvIndex: weatherVM.currentWeather?.uvi ?? 0, darkMode: $darkMode)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        let sunriseTimestamp = TimeInterval(weatherVM.currentWeather?.sunrise ?? 0)
                        let sunsetTimestamp = TimeInterval(weatherVM.currentWeather?.sunset ?? 0)

                        let sunriseTime = formatTimeFromTimestamp(sunriseTimestamp, timezoneOffset: city.timeZoneOffset)
                        let sunsetTime = formatTimeFromTimestamp(sunsetTimestamp, timezoneOffset: city.timeZoneOffset)

                        SunsetView(sunsetTime: sunsetTime, sunriseTime: sunriseTime, darkMode: $darkMode)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                
                Grid {
                    GridRow {
                        VisibilityView(visibility: weatherVM.currentWeather?.visibility ?? 0, darkMode: $darkMode)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        CloudinessView(cloudiness: weatherVM.currentWeather?.clouds ?? 0, timeZoneOffset: city.timeZoneOffset, darkMode: $darkMode)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                
                let moonriseTimestamp = TimeInterval(weatherVM.dailyWeather.first?.moonrise ?? 0)
                let moonsetTimestamp = TimeInterval(weatherVM.dailyWeather.first?.moonset ?? 0)
                
                let moonriseTime = formatTimeFromTimestamp(moonriseTimestamp, timezoneOffset: city.timeZoneOffset)
                let moonsetTime = formatTimeFromTimestamp(moonsetTimestamp, timezoneOffset: city.timeZoneOffset)
                
                MoonView(moonPhase: weatherVM.dailyWeather.first?.moonPhase ?? 0, moonset: moonsetTime, moonrise: moonriseTime, darkMode: $darkMode)
                
                Grid {
                    GridRow {
                        HumidityView(humidity: weatherVM.currentWeather?.humidity ?? 0, drewPoint: weatherVM.currentWeather?.dewPoint ?? 0, darkMode: $darkMode)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        PressureView(pressure: weatherVM.currentWeather?.pressure ?? 0, darkMode: $darkMode)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                
                AirQulityView(airQualityData: weatherVM.airQuality ?? AirQualityModel(from: dummyAirQulityResponseDTO), darkMode: $darkMode)
                
                Divider()
                    .overlay(Color.white.opacity(0.3))
                    .padding(.top, 10)
                    .padding(.bottom, 6)
                
                Button {
                    let appleMapsUrl = "http://maps.apple.com/?ll=\(city.lat),\(city.lon)&q=\(city.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                            
                            if let url = URL(string: appleMapsUrl) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                } label: {
                    HStack {
                        Text("Open in Maps")
                        Spacer()
                        Image(systemName: "arrow.up.forward.app.fill")
                    }
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.8))
                }
                
                Divider()
                    .overlay(Color.white.opacity(0.3))
                    .padding(.top, 6)
                    .padding(.bottom, 16)
                
                VStack {
                    Text("Weather for \(city.name), \(city.country ?? "")")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 3)
                    HStack(spacing: 2) {
                        Text("Learn more about")
                        Link(destination: URL(string: "https://openweathermap.org")!) {
                            Text("OpenWeatherMap")
                                .underline()
                        }
                        Text(" and")
                        Link(destination: URL(string: "https://www.apple.com/maps/")!) {
                            Text("map data")
                                .underline()
                        }
                    }
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.bottom, 90)
            }
            .padding()
            
            if weatherVM.errorMessage != nil {
                NetworkErrorView()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                await weatherVM.fetchWeather(id: city.id, lat: city.lat, lon: city.lon, units: units)
            }
        }
    }
}

#Preview {
    WeatherView(city: colomboCity, units: .constant(.metric), darkMode: .constant(false))
}
