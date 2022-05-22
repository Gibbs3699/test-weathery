//
//  CurrentWeather.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation

struct CurrentWeather: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main: Codable {
    let temp : Double
    let humidity : Double
}

struct Weather: Codable {
    let description : String
    let id : Int
}
