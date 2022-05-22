//
//  CurrentWeatherViewModel.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation
import UIKit


struct CurrentWeatherViewModel {

    let conditionId: Int
    let cityName: String
    let temperature: Double
    let humidity: Double
    let conditionDescription: String

    var temperatureString : String {
        let tempRounded = String(format: "%.1f", temperature)
        return "\(tempRounded) °C"
    }

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

}

