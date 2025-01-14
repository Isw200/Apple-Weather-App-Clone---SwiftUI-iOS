//
//  DailyWeatherModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import Foundation

struct DailyWeatherModel: Hashable {
    let day: String
    let minTemperature: Double
    let maxTemperature: Double
    let weatherIcon: String
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int?
    let moonPhase: Double?
    let pop: Double?

    init(from dto: DailyWeather) {
        let date = Date(timeIntervalSince1970: TimeInterval(dto.dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        self.day = formatter.string(from: date)
        self.minTemperature = dto.temp.min
        self.maxTemperature = dto.temp.max
        self.weatherIcon = dto.weather.first?.icon ?? "01d"
        self.sunrise = dto.sunrise
        self.sunset = dto.sunset
        self.moonrise = dto.moonrise
        self.moonset = dto.moonset ?? 0
        self.moonPhase = dto.moonPhase ?? 0
        self.pop = dto.pop
    }
}
