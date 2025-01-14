//
//  Functions.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import Foundation

public func getSfSymbol(strIcon: String) -> String {
    switch strIcon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d": return "cloud.fill"
        case "03n": return "cloud.fill"
        case "04d": return "smoke.fill"
        case "04n": return "smoke.fill"
        case "09d": return "cloud.drizzle.fill"
        case "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d": return "cloud.bolt.fill"
        case "11n": return "cloud.bolt.fill"
        case "13d": return "snowflake"
        case "13n": return "snowflake"
        case "50d": return "aqi.medium"
        case "50n": return "aqi.medium"
        default : return "cloud.fill"
    }
}

public func sliceDayIntoThreeLetters(day: String) -> String {
    let startIndex = day.index(day.startIndex, offsetBy: 0)
    let endIndex = day.index(day.startIndex, offsetBy: 2)
    
    let slicedDay = day[startIndex...endIndex]
    
    return String(slicedDay)
}

public func getWindDirection(windDirection: Double) -> String {
    switch windDirection {
    case 0..<11.25: return "N"
    case 11.25..<33.75: return "NNE"
    case 33.75..<56.25: return "NE"
    case 56.25..<78.75: return "ENE"
    case 78.75..<101.25: return "E"
    case 101.25..<123.75: return "ESE"
    case 123.75..<146.25: return "SE"
    case 146.25..<168.75: return "SSE"
    case 168.75..<191.25: return "S"
    case 191.25..<213.75: return "SSW"
    case 213.75..<236.25: return "SW"
    case 236.25..<258.75: return "WSW"
    case 258.75..<281.25: return "W"
    case 281.25..<303.75: return "WNW"
    case 303.75..<326.25: return "NW"
    case 326.25..<348.75: return "NNW"
    default: return "N"
    }
}

func formatTimeFromTimestamp(_ timestamp: TimeInterval, timezoneOffset: Double) -> String {
    let date = Date(timeIntervalSince1970: timestamp)
    
    let offsetInSeconds = timezoneOffset * 3600
    
    let adjustedDate = date.addingTimeInterval(offsetInSeconds)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    return dateFormatter.string(from: adjustedDate)
}


func generateCityId(lat: Double, lon: Double) -> String {
    return String(lat) + String(lon)
}

func getCurrentTime(timeZoneOffset: Double, format: String) -> String {
    let currentDate = Date()
    
    let offsetInSeconds = Int(timeZoneOffset * 3600)
    
    guard let timeZone = TimeZone(secondsFromGMT: offsetInSeconds) else {
        return "Invalid time zone offset"
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = timeZone
    
    switch format {
        case "fullDate":
            dateFormatter.dateFormat = "EEEE, MMMM d, yyyy HH:mm:ss"
        case "time12h":
            dateFormatter.dateFormat = "hh:mm a"
        case "time24h":
            dateFormatter.dateFormat = "HH:mm"
        case "dateOnly":
            dateFormatter.dateFormat = "yyyy-MM-dd"
        default:
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    return dateFormatter.string(from: currentDate)
}


func capitalizeFirstLetter(_ string: String) -> String {
    guard !string.isEmpty else { return string }
    return string.prefix(1).uppercased() + string.dropFirst()
}

func getOverlayIocn(overlay: WeatherOverlayType) -> String {
    switch overlay {
    case .clouds_new:
        return "smoke"
    case .precipitation_new
        : return "umbrella"
    case .wind_new:
        return "wind"
    case .pressure_new:
        return "aqi.medium"
    case .temp_new:
        return "thermometer.medium"
    }
}
