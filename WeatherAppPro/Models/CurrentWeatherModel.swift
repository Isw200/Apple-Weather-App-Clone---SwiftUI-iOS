//
//  CurrentWeatherModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import Foundation

struct CurrentWeatherModel {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weatherType: Int
    let weatherDescription: String
    let weatherIcon: String
    let rain: Double?

    init(from dto: CurrentWeather) {
        self.dt = dto.dt
        self.sunrise = dto.sunrise
        self.sunset = dto.sunset
        self.temp = dto.temp
        self.feelsLike = dto.feelsLike ?? 0
        self.pressure = dto.pressure
        self.humidity = dto.humidity
        self.dewPoint = dto.dewPoint ?? 0
        self.uvi = dto.uvi
        self.clouds = dto.clouds
        self.visibility = dto.visibility ?? 0
        self.windSpeed = dto.windSpeed ?? 0
        self.windDeg = dto.windDeg ?? 0
        self.windGust = dto.windGust ?? 0
        self.weatherDescription = dto.weather.first?.description ?? "N/A"
        self.weatherType = dto.weather.first?.id ?? 0
        self.weatherIcon = dto.weather.first?.icon ?? "01d"
        self.rain = dto.rain?.oneHour
    }
}
