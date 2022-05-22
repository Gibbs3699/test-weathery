//
//  Constants.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation

public struct APIClient {
    static let apiKey: String =  "f8788d0330fcd61f7b655c9709c833bd"
    static let baseUrl: String = "https://api.openweathermap.org"

    static func getCurrentWeather(city: String) -> String {
        return "\(baseUrl)/data/2.5/weather?q=\(city)&appid=\(apiKey)"
    }
}
