//
//  ForecastWeather.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation

struct ForecastWeatherList {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
}

struct WeatherInfo {
    let temp: Double
    let humidity: Double
    let description: String
    let time: String
    let id: Int
    let icon: String
}

struct ForecastWeather: Codable {
    let city: City
    let list: [WeatherArray]
}

struct WeatherArray: Codable {
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

struct City: Codable {
    let name: String
}

