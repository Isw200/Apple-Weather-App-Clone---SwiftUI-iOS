//
//  ApiEndPoints.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import Foundation

private let baseUrl = "https://api.openweathermap.org/data/3.0/onecall"
private let apiKey = "YOUR_API_KEY_ON_OPENWEATHERMAP"
private let exclude = "minutely,alerts"

private let cityCurrentWeatherBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
private let overlayBaseUrl = "https://tile.openweathermap.org/map/"
private let ariQulityBaseUrl = "https://api.openweathermap.org/data/2.5/air_pollution"

public func apiEndPoint(lat: Double, lon: Double, unit: WeatherUnit) -> String {
    return "\(baseUrl)?lat=\(lat)&lon=\(lon)&exclude=\(exclude)&appid=\(apiKey)&units=\(unit.rawValue)"
}

public func cityCurrentWeatherEndPoint(lat: Double, lon: Double, unit: WeatherUnit) -> String {
    return "\(cityCurrentWeatherBaseUrl)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(unit)"
}

public func mapOverlayEndPoint(selectedLayerType: WeatherOverlayType) -> String {
    return "\(overlayBaseUrl)\(selectedLayerType)/{z}/{x}/{y}.png?appid=\(apiKey)"
}

public func airQualityEndPoint(lat: Double, lon: Double, unit: WeatherUnit) -> String {
    return "\(ariQulityBaseUrl)?lat=\(lat)&lon=\(lon)&units=\(unit)&appid=\(apiKey)"
    
}
