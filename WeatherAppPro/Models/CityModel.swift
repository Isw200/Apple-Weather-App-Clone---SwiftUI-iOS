//
//  CityModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import Foundation

struct CityModel: Identifiable, Hashable, Equatable  {
    let id: String
    var name: String
    let lat: Double
    let lon: Double
    let timeZoneOffset: Double
    let country: String?
    var isLoading: Bool = false
    var cityWeather: CityWeatherModel? = nil
    
    init(id: String, name: String, lat: Double, lon: Double, timeZoneOffset: Double, country: String?, cityWeather: CityWeatherModel?) {
        self.id = id
        self.name = name
        self.lat = lat
        self.lon = lon
        self.timeZoneOffset = timeZoneOffset
        self.country = country
        self.cityWeather = cityWeather
    }
}

let londonCity = CityModel(id: "51.5073-0.1277", name: "London", lat: 51.5073, lon: -0.1277, timeZoneOffset: 0, country: "GB", cityWeather: nil)
let colomboCity = CityModel(id: "6.92707979.861244", name: "Moratuwa", lat: 6.927079, lon: 79.861244, timeZoneOffset: 19800, country: "SL", cityWeather: nil)
