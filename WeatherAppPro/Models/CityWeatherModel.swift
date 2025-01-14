//
//  CityWeatherModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-18.
//

import Foundation

struct CityWeatherModel : Hashable, Equatable {
    let id: String
    let lat: Double
    let lon: Double
    let name: String
    let temp: Double
    let minTemp: Double
    let maxTemp: Double
    let humidity: Double
    let weatherType: Int
    let description: String
    let icon: String
    let pressure: Double
    let windSpeed: Double
    let clouds: Double
    
    init(from dto: CityWeatherResponse) {
        self.id = generateCityId(lat: dto.coord.lat, lon: dto.coord.lon)
        self.lat = dto.coord.lat
        self.lon = dto.coord.lon
        self.name = dto.name
        self.temp = dto.main.temp
        self.minTemp = dto.main.tempMin
        self.maxTemp = dto.main.tempMax
        self.weatherType = dto.weather.first?.id ?? 0
        self.description = dto.weather.first?.description ?? ""
        self.icon = dto.weather.first?.icon ?? ""
        self.pressure = dto.main.pressure
        self.windSpeed = dto.wind.speed
        self.clouds = dto.clouds.all
        self.humidity = dto.main.humidity
    }
}

let dummyCityWeatherModel: CityWeatherModel = .init(from: cityWeatherResponse)
