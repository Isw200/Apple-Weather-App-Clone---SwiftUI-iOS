//
//  CityWeatherDTO.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-18.
//

import Foundation

struct CityWeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
    let clouds: Clouds
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Double
}

struct Main: Codable {
    let temp, tempMin, tempMax, pressure, humidity: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// DUMMY
let cityWeatherResponse = CityWeatherResponse(
    coord: Coord(lon: 123456789, lat: 987654321),
    weather: [
        Weather(id: 501 ,main: "Clouds", description: "dummy Description", icon: "cloud"),
    ],
    main: Main(temp: 20, tempMin: 10, tempMax: 30, pressure: 100, humidity: 10),
    name: "Dummy City",
    wind: Wind(speed: 10),
    clouds: Clouds(all: 100)
)
