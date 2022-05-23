//
//  ForecastWeatherViewModel.swift
//  Weathery
//
//  Created by TheGIZzz on 23/5/2565 BE.
//

import Foundation

struct ForecastWeatherViewModel {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
    let conditionId: Int
    let temperature: Double
    let humidity: Double
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "thunder"
        case 300...321:
            return "dizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "sun"
        case 801...804:
            return "cloudy"
        default:
            return "cloud"
        }
    }
    
    var temperatureString : String {
        let tempRounded = String(format: "%.1f", temperature)
        
        if UserDefaults.standard.value(forKey: "unit") as! String == "metric" {
            return "\(tempRounded) °C"
        } else {
            return "\(tempRounded) °F"
        }
    }
    
    var humidityString : String {
        let humidity = String(format: "%.1f", humidity)
        
        return "\(humidity) °"
    }
    
}

