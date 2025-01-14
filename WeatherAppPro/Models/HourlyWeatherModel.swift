//
//  HourlyWeatherModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import Foundation

struct HourlyWeatherModel : Hashable {
    let time: String
    let temp: Double
    let weatherIcon: String
    let main: String
    let pop: Double
    let windSpeed: Double
    let clouds: Int

    init(from dto: HourlyWeather) {
        let date = Date(timeIntervalSince1970: TimeInterval(dto.dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        self.time = formatter.string(from: date)
        self.temp = dto.temp
        self.weatherIcon = dto.weather.first?.icon ?? "01d"
        self.main = dto.weather.first?.main ?? ""
        self.pop = dto.pop
        self.windSpeed = dto.windSpeed ?? 0
        self.clouds = dto.clouds
    }
}
