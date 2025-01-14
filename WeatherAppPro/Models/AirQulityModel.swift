//
//  AirQulityModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-12.
//

import Foundation

struct AirQualityModel: Hashable, Equatable {
    let id: String
    let airQualityIndex: Int
    let components: [AirQulityComponent]
    let timestamp: Int

    init(from dto: AirQulityResponseDTO) {
        self.id = generateCityId(lat: dto.coord.lat, lon: dto.coord.lon)
        self.airQualityIndex = dto.list.first?.main.aqi ?? 0
        self.components = dto.list.first?.components.map { AirQulityComponent(name: $0.key, value: $0.value) } ?? []
        self.timestamp = dto.list.first?.dt ?? 0
    }
}

struct AirQulityComponent: Hashable, Equatable {
    let name: String
    let value: Double
}

let dummyAirQualityModel: AirQualityModel = .init(from: dummyAirQulityResponseDTO)
