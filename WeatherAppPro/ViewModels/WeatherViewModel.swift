//
//  WeatherViewModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherModel?
    @Published var hourlyWeather: [HourlyWeatherModel] = []
    @Published var dailyWeather: [DailyWeatherModel] = []
    @Published var airQuality: AirQualityModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchWeather(id: String, lat: Double, lon: Double, units: WeatherUnit) async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        let url = URL(string: apiEndPoint(lat: lat, lon: lon, unit: units))
        guard let unwrappedUrl = url else {
            isLoading = false
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: unwrappedUrl)
            
            guard let response = response as? HTTPURLResponse else {
                isLoading = false
                errorMessage = "Invalid response"
                return
            }
                        
            switch response.statusCode {
                case 200 :
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                                
                    DispatchQueue.main.async {
                        self.currentWeather = CurrentWeatherModel(from: weatherResponse.current)
                        self.hourlyWeather = weatherResponse.hourly.map { HourlyWeatherModel(from: $0) }
                        self.dailyWeather = weatherResponse.daily.map { DailyWeatherModel(from: $0) }
                        self.isLoading = false
                    }
                
                    await fetchAirQualityData(lat: lat, lon: lon, unit: units)
                
                case 400...599 :
                    errorMessage = "Server error"
                    print("Error: \(response.statusCode)")
                default:
                    isLoading = false
                    errorMessage = "Unknown error"
                    print("Error: \(response.statusCode)")
            }
            
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
            print("Error: \(error)")
        }
    }
    
    func getAverageTemperature(dailyWeather:[DailyWeatherModel]) -> Double {
        var temperatureSum: Double = 0
        
        for weather in dailyWeather {
            temperatureSum += weather.maxTemperature
        }
        
        print("Average temperature: %f", temperatureSum / Double(dailyWeather.count))
        
        return temperatureSum / Double(dailyWeather.count)
    }
    
    func fetchAirQualityData(lat: Double, lon: Double, unit: WeatherUnit) async {
        let url =  URL(string: airQualityEndPoint(lat: lat, lon: lon, unit: unit))
        guard let airQualityURL = url else {
            print("Error creating URL for air quality")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: airQualityURL)
            
            guard let response = response as? HTTPURLResponse else {
                print("Error fetching air quality data")
                return
            }
            
            switch response.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    let airQulityResponse = try decoder.decode(AirQulityResponseDTO.self, from: data)
                
                    DispatchQueue.main.async {
                        self.airQuality = AirQualityModel(from: airQulityResponse)
                    }
                case 400...599:
                    print("Error fetching air quality data (status code: \(response.statusCode))")
                default:
                    print("Error fetching air quality data (status code: \(response.statusCode))")
                    return
                }
            
        } catch {
            print("Error fetching air quality data: \(error)")
        }
    }
}
