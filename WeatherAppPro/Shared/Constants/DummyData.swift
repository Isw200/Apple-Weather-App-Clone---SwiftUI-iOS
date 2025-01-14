//
//  DummyData.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import Foundation

let dummyDailyWeatherData : DailyWeather = DailyWeather(
    dt: 1733335200,
    sunrise: 1733317516,
    sunset: 1733353698,
    moonrise: 1733329260,
    moonset: 1733364840,
    moonPhase: 0.11,
    summary: "Expect a day of partly cloudy with rain",
    temp: Temperature(
        day: 9.98,
        min: 3.09,
        max: 10.68,
        night: 8.52,
        eve: 10.39,
        morn: 5.14
    ),
    feelsLike: FeelsLike(
        day: 8.95,
        night: 7.86,
        eve: 10.04,
        morn: 3.11
    ),
    pressure: 1024,
    humidity: 88,
    dewPoint: 8.1,
    windSpeed: 3.19,
    windDeg: 184,
    windGust: 9.66,
    weather: [
        WeatherCondition(
            id: 501,
            main: "Rain",
            description: "moderate rain",
            icon: "10d"
        )
    ],
    clouds: 100,
    pop: 1.0,
    rain: 9.06,
    uvi: 0.0
)

let dummyHourlyWeatherData : HourlyWeather = HourlyWeather(
    dt: 1733371200,
    temp: 8.92,
    feelsLike: 8.47,
    pressure: 1022,
    humidity: 95,
    dewPoint: 8.16,
    uvi: 0.0,
    clouds: 100,
    visibility: 10000,
    windSpeed: 1.45,
    windDeg: 327,
    windGust: 1.88,
    weather: [
        WeatherCondition(
            id: 804,
            main: "Clouds",
            description: "overcast clouds",
            icon: "04n"
        )
    ],
    pop: 0.0,
    rain: nil
)

let dummyHourlyWeatherDummyData: [HourlyWeatherModel] = [
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733371200,
        temp: 8.92,
        feelsLike: 8.47,
        pressure: 1022,
        humidity: 95,
        dewPoint: 8.16,
        uvi: 0.0,
        clouds: 100,
        visibility: 10000,
        windSpeed: 1.45,
        windDeg: 327,
        windGust: 1.88,
        weather: [
            WeatherCondition(
                id: 804,
                main: "Clouds",
                description: "overcast clouds",
                icon: "04n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733374800,
        temp: 8.52,
        feelsLike: 7.86,
        pressure: 1022,
        humidity: 94,
        dewPoint: 7.61,
        uvi: 0.0,
        clouds: 100,
        visibility: 10000,
        windSpeed: 1.59,
        windDeg: 337,
        windGust: 2.49,
        weather: [
            WeatherCondition(
                id: 804,
                main: "Clouds",
                description: "overcast clouds",
                icon: "04n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733378400,
        temp: 8.87,
        feelsLike: 7.83,
        pressure: 1022,
        humidity: 95,
        dewPoint: 8.11,
        uvi: 0.0,
        clouds: 100,
        visibility: 10000,
        windSpeed: 2.05,
        windDeg: 343,
        windGust: 3.55,
        weather: [
            WeatherCondition(
                id: 804,
                main: "Clouds",
                description: "overcast clouds",
                icon: "04n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733382000,
        temp: 8.95,
        feelsLike: 7.46,
        pressure: 1022,
        humidity: 96,
        dewPoint: 8.35,
        uvi: 0.0,
        clouds: 73,
        visibility: 10000,
        windSpeed: 2.68,
        windDeg: 351,
        windGust: 5.45,
        weather: [
            WeatherCondition(
                id: 803,
                main: "Clouds",
                description: "broken clouds",
                icon: "04n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733385600,
        temp: 8.65,
        feelsLike: 6.93,
        pressure: 1023,
        humidity: 96,
        dewPoint: 8.05,
        uvi: 0.0,
        clouds: 57,
        visibility: 10000,
        windSpeed: 2.94,
        windDeg: 4,
        windGust: 6.73,
        weather: [
            WeatherCondition(
                id: 803,
                main: "Clouds",
                description: "broken clouds",
                icon: "04n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733389200,
        temp: 8.14,
        feelsLike: 6.26,
        pressure: 1023,
        humidity: 95,
        dewPoint: 7.39,
        uvi: 0.0,
        clouds: 39,
        visibility: 10000,
        windSpeed: 3.03,
        windDeg: 12,
        windGust: 6.9,
        weather: [
            WeatherCondition(
                id: 802,
                main: "Clouds",
                description: "scattered clouds",
                icon: "03n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733392800,
        temp: 7.66,
        feelsLike: 5.65,
        pressure: 1024,
        humidity: 92,
        dewPoint: 6.59,
        uvi: 0.0,
        clouds: 30,
        visibility: 10000,
        windSpeed: 3.08,
        windDeg: 18,
        windGust: 8.65,
        weather: [
            WeatherCondition(
                id: 802,
                main: "Clouds",
                description: "scattered clouds",
                icon: "03n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733396400,
        temp: 6.98,
        feelsLike: 4.74,
        pressure: 1024,
        humidity: 91,
        dewPoint: 5.72,
        uvi: 0.0,
        clouds: 27,
        visibility: 10000,
        windSpeed: 3.22,
        windDeg: 23,
        windGust: 9.99,
        weather: [
            WeatherCondition(
                id: 802,
                main: "Clouds",
                description: "scattered clouds",
                icon: "03n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733400000,
        temp: 6.29,
        feelsLike: 3.97,
        pressure: 1025,
        humidity: 91,
        dewPoint: 5.0,
        uvi: 0.0,
        clouds: 25,
        visibility: 10000,
        windSpeed: 3.12,
        windDeg: 29,
        windGust: 9.73,
        weather: [
            WeatherCondition(
                id: 802,
                main: "Clouds",
                description: "scattered clouds",
                icon: "03n"
            )
        ],
        pop: 0.0,
        rain: nil
    )),
    HourlyWeatherModel(from: HourlyWeather(
        dt: 1733403600,
        temp: 5.75,
        feelsLike: 3.19,
        pressure: 1027,
        humidity: 91,
        dewPoint: 4.37,
        uvi: 0.0,
        clouds: 28,
        visibility: 10000,
        windSpeed: 3.32,
        windDeg: 33,
        windGust: 11.13,
        weather: [
            WeatherCondition(
                id: 802,
                main: "Clouds",
                description: "scattered clouds",
                icon: "03n"
            )
        ],
        pop: 0.0,
        rain: nil
    ))
]

let dummyTenDayWeatherDummyData: [DailyWeatherModel] = [
    DailyWeatherModel(from: DailyWeather(
        dt: 1733335200,
        sunrise: 1733317516,
        sunset: 1733353698,
        moonrise: 1733329260,
        moonset: 1733364840,
        moonPhase: 0.11,
        summary: "Expect a day of partly cloudy with rain",
        temp: Temperature(day: 9.98, min: 3.09, max: 10.68, night: 8.52, eve: 10.39, morn: 5.14),
        feelsLike: FeelsLike(day: 8.95, night: 7.86, eve: 10.04, morn: 3.11),
        pressure: 1024,
        humidity: 88,
        dewPoint: 8.1,
        windSpeed: 3.19,
        windDeg: 184,
        windGust: 9.66,
        weather: [
            WeatherCondition(id: 501, main: "Rain", description: "moderate rain", icon: "10d")
        ],
        clouds: 100,
        pop: 1.0,
        rain: 9.06,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733421600,
        sunrise: 1733403965,
        sunset: 1733440099,
        moonrise: 1733418180,
        moonset: 1733455320,
        moonPhase: 0.15,
        summary: "There will be partly cloudy today",
        temp: Temperature(day: 10.04, min: 2.21, max: 10.88, night: 2.21, eve: 6.51, morn: 6.29),
        feelsLike: FeelsLike(day: 8.27, night: -1.07, eve: 4.13, morn: 3.97),
        pressure: 1029,
        humidity: 45,
        dewPoint: -1.25,
        windSpeed: 5.88,
        windDeg: 38,
        windGust: 12.21,
        weather: [
            WeatherCondition(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")
        ],
        clouds: 80,
        pop: 0.0,
        rain: nil,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733508000,
        sunrise: 1733490412,
        sunset: 1733526501,
        moonrise: 1733506800,
        moonset: 1733545740,
        moonPhase: 0.18,
        summary: "Expect a day of partly cloudy with clear spells",
        temp: Temperature(day: 7.33, min: -1.46, max: 9.62, night: 6.57, eve: 6.29, morn: -1.1),
        feelsLike: FeelsLike(day: 5.09, night: 4.71, eve: 4.58, morn: -4.83),
        pressure: 1031,
        humidity: 28,
        dewPoint: -10.07,
        windSpeed: 4.18,
        windDeg: 74,
        windGust: 8.72,
        weather: [
            WeatherCondition(id: 801, main: "Clouds", description: "few clouds", icon: "02d")
        ],
        clouds: 13,
        pop: 0.0,
        rain: nil,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733594400,
        sunrise: 1733576859,
        sunset: 1733612905,
        moonrise: 1733595060,
        moonset: 1733636160,
        moonPhase: 0.22,
        summary: "Expect a day of partly cloudy with rain",
        temp: Temperature(day: 9.44, min: 4.49, max: 9.8, night: 7.87, eve: 7.51, morn: 4.94),
        feelsLike: FeelsLike(day: 8.5, night: 6.91, eve: 5.55, morn: 4.94),
        pressure: 1027,
        humidity: 77,
        dewPoint: 5.66,
        windSpeed: 3.1,
        windDeg: 149,
        windGust: 7.06,
        weather: [
            WeatherCondition(id: 500, main: "Rain", description: "light rain", icon: "10d")
        ],
        clouds: 99,
        pop: 1.0,
        rain: 4.07,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733680800,
        sunrise: 1733663305,
        sunset: 1733699311,
        moonrise: 1733683260,
        moonset: nil,
        moonPhase: 0.25,
        summary: "There will be partly cloudy until morning, then rain",
        temp: Temperature(day: 11.4, min: 8.13, max: 15.12, night: 15.12, eve: 14.15, morn: 8.72),
        feelsLike: FeelsLike(day: 11.18, night: 15.25, eve: 14.21, morn: 7.89),
        pressure: 1016,
        humidity: 99,
        dewPoint: 11.32,
        windSpeed: 3.47,
        windDeg: 228,
        windGust: 11.0,
        weather: [
            WeatherCondition(id: 502, main: "Rain", description: "heavy intensity rain", icon: "10d")
        ],
        clouds: 100,
        pop: 1.0,
        rain: 48.4,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733767200,
        sunrise: 1733749749,
        sunset: 1733785719,
        moonrise: 1733771340,
        moonset: 1733726460,
        moonPhase: 0.29,
        summary: "Expect a day of partly cloudy with clear spells",
        temp: Temperature(day: 20.5, min: 13.32, max: 22.12, night: 16.5, eve: 16.94, morn: 15.48),
        feelsLike: FeelsLike(day: 20.41, night: 16.48, eve: 16.91, morn: 15.49),
        pressure: 1012,
        humidity: 69,
        dewPoint: 14.72,
        windSpeed: 4.4,
        windDeg: 203,
        windGust: 6.92,
        weather: [
            WeatherCondition(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")
        ],
        clouds: 36,
        pop: 0,
        rain: nil,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733853600,
        sunrise: 1733836193,
        sunset: 1733872129,
        moonrise: 1733859540,
        moonset: 1733816940,
        moonPhase: 0.33,
        summary: "There will be partly cloudy today",
        temp: Temperature(day: 17.61, min: 8.54, max: 17.61, night: 8.54, eve: 10.51, morn: 10.57),
        feelsLike: FeelsLike(day: 17.18, night: 5.17, eve: 9.65, morn: 10.08),
        pressure: 1015,
        humidity: 67,
        dewPoint: 11.48,
        windSpeed: 7.28,
        windDeg: 25,
        windGust: 12.66,
        weather: [
            WeatherCondition(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")
        ],
        clouds: 95,
        pop: 0,
        rain: nil,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1733940000,
        sunrise: 1733922635,
        sunset: 1733958540,
        moonrise: 1733947860,
        moonset: 1733907480,
        moonPhase: 0.36,
        summary: "You can expect rain with snow in the morning, with partly cloudy with clear spells in the afternoon",
        temp: Temperature(day: 2.38, min: 2.1, max: 6.39, night: 2.1, eve: 3.99, morn: 4.64),
        feelsLike: FeelsLike(day: -1.74, night: -1.48, eve: 1.49, morn: 0.56),
        pressure: 1021,
        humidity: 98,
        dewPoint: 2.11,
        windSpeed: 5.88,
        windDeg: 16,
        windGust: 12.35,
        weather: [
            WeatherCondition(id: 616, main: "Snow", description: "rain and snow", icon: "13d")
        ],
        clouds: 100,
        pop: 1.0,
        rain: 11.52,
        uvi: 0
    )),
    DailyWeatherModel(from: DailyWeather(
        dt: 1734026400,
        sunrise: 1734009082,
        sunset: 1734044956,
        moonrise: 1734036265,
        moonset: 1733997885,
        moonPhase: 0.4,
        summary: "Clear skies throughout the day",
        temp: Temperature(day: 8.78, min: 3.21, max: 12.45, night: 5.89, eve: 8.14, morn: 3.98),
        feelsLike: FeelsLike(day: 7.88, night: 4.85, eve: 7.12, morn: 2.96),
        pressure: 1023,
        humidity: 65,
        dewPoint: 5.48,
        windSpeed: 4.1,
        windDeg: 90,
        windGust: 9.0,
        weather: [
            WeatherCondition(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        ],
        clouds: 5,
        pop: 0.0,
        rain: nil,
        uvi: 0
    ))
]
