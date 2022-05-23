//
//  Constants.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation
import CoreLocation

struct APIClient {
    static let apiKey: String =  "f8788d0330fcd61f7b655c9709c833bd"
    static let baseUrl: String = "https://api.openweathermap.org"
    
    let unit = (UserDefaults.standard.value(forKey: "unit") as? String) ?? "metric"
    
    static func getCurrentWeather(city: String) -> String {
        let unit = (UserDefaults.standard.value(forKey: "unit") as? String) ?? "metric"
        
        return "\(baseUrl)/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=\(unit)"
    }
    
    static func getForecasteWeather(city: String) -> String {
        let unit = (UserDefaults.standard.value(forKey: "unit") as? String) ?? "metric"
        
        return "\(baseUrl)/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=\(unit)"
    }
    
    static func getCurrentLocationWeather(latitude: String, longtitude: String) -> String {
        let unit = (UserDefaults.standard.value(forKey: "unit") as? String) ?? "metric"
        
        return "\(baseUrl)/data/2.5/weather?appid=\(apiKey)&units=\(unit)&lat=\(latitude)&lon=\(longtitude)"
    }
}
