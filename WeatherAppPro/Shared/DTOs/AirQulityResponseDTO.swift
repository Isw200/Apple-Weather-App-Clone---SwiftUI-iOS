//
//  AirQulityResponseDTO.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-12.
//

import Foundation

struct AirQulityResponseDTO: Codable {
    let coord: CoordDTO
    let list: [ListDTO]
}

struct CoordDTO: Codable {
    let lon, lat: Double
}

struct ListDTO: Codable {
    let main: AQMainDTO
    let components: [String: Double]
    let dt: Int
}

struct AQMainDTO: Codable {
    let aqi: Int
}

// dummy
let dummyAirQulityResponseDTO = AirQulityResponseDTO(
    coord: CoordDTO(lon: 79.8612, lat: 6.9271),
    list: [
        ListDTO(
            main: AQMainDTO(aqi: 3),
            components: [
                "co": 250.34,
                "no": 0,
                "no2": 0,
                "o3": 64.37,
                "so2": 0.41,
                "pm2_5": 1.98,
                "pm10": 6.23,
                "nh3": 0.24
            ],
            dt: 1672531200
        )
    ]
)
