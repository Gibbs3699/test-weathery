//
//  Webservice.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation
import Alamofire
import CoreLocation

enum NetworkResult<T> {
    case Success(T)
    case Error(Error)
}

class Webservice {
    
    static let shared = Webservice()
    
    func getCurrentWeather(city: String, completion: @escaping (NetworkResult<CurrentWeather>) -> Void) {
        
        guard let url = URL(string: APIClient.getCurrentWeather(city: city)) else { return }

        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion(.Success(result))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
    
    func getCurrentLocationWeather(lat: String, lon: String , completion: @escaping (NetworkResult<CurrentWeather>) -> Void) {
        
        guard let url = URL(string: APIClient.getCurrentLocationWeather(latitude: lat, longtitude: lon)) else { return }
            
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion(.Success(result))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
    
    func getForecastWeather(city: String, completion: @escaping (NetworkResult<[ForecastWeatherList]>) -> Void) {
        
        guard let url = URL(string: APIClient.getForecasteWeather(city: city)) else { return }

        var currentDayTemp = ForecastWeatherList(weekDay: nil, hourlyForecast: nil)
        var secondDayTemp = ForecastWeatherList(weekDay: nil, hourlyForecast: nil)
        var thirdDayTemp = ForecastWeatherList(weekDay: nil, hourlyForecast: nil)
        var fourthDayTemp = ForecastWeatherList(weekDay: nil, hourlyForecast: nil)
        var fifthDayTemp = ForecastWeatherList(weekDay: nil, hourlyForecast: nil)
        var sixthDayTemp = ForecastWeatherList(weekDay: nil, hourlyForecast: nil)
        
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ForecastWeather.self, from: data)
                
                var forecastmodelArray : [ForecastWeatherList] = []
                var fetchedData : [WeatherInfo] = [] //Just for loop completion
                
                var currentDayForecast : [WeatherInfo] = []
                var secondDayForecast : [WeatherInfo] = []
                var thirddayDayForecast : [WeatherInfo] = []
                var fourthDayDayForecast : [WeatherInfo] = []
                var fifthDayForecast : [WeatherInfo] = []
                var sixthDayForecast : [WeatherInfo] = []
                
                var totalData = result.list.count
                
                for day in 0...result.list.count - 1 {
                    
                    let listIndex = day//(8 * day) - 1
                    let temperature = result.list[listIndex].main.temp
                    let humidity = result.list[listIndex].main.humidity
                    let descriptionTemp = result.list[listIndex].weather[0].description
                    let time = result.list[listIndex].dt_txt
                    let id = result.list[listIndex].weather[0].id
                    let icon = result.list[listIndex].weather[0].icon
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.calendar = Calendar(identifier: .gregorian)
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatter.date(from: result.list[listIndex].dt_txt)
                    
                    let calendar = Calendar.current
                    
                    let components = calendar.dateComponents([.weekday], from: date!)
                    let weekdaycomponent = components.weekday! - 1
                    
                    let f = DateFormatter()
                    let weekday = f.weekdaySymbols[weekdaycomponent]
                        
                    let currentDayComponent = calendar.dateComponents([.weekday], from: Date())
                    let currentWeekDay = currentDayComponent.weekday! - 1
                    
                    let currentweekdaysymbol = f.weekdaySymbols[currentWeekDay]
                    
                    if weekdaycomponent == currentWeekDay - 1 {
                        totalData = totalData - 1
                    }
                    
                    
                    if weekdaycomponent == currentWeekDay {
                        let info = WeatherInfo(temp: temperature, humidity: humidity, description: descriptionTemp, time: time, id: id, icon: icon)
                        currentDayForecast.append(info)
                        currentDayTemp = ForecastWeatherList(weekDay: currentweekdaysymbol, hourlyForecast: currentDayForecast)
                        
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 1) {
                        let info = WeatherInfo(temp: temperature, humidity: humidity, description: descriptionTemp, time: time, id: id, icon: icon)
                        secondDayForecast.append(info)
                        secondDayTemp = ForecastWeatherList(weekDay: weekday, hourlyForecast: secondDayForecast)
                        
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 2) {
                        let info = WeatherInfo(temp: temperature, humidity: humidity, description: descriptionTemp, time: time, id: id, icon: icon)
                        thirddayDayForecast.append(info)
                        
                        thirdDayTemp = ForecastWeatherList(weekDay: weekday, hourlyForecast: thirddayDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 3) {
                        let info = WeatherInfo(temp: temperature, humidity: humidity, description: descriptionTemp, time: time, id: id, icon: icon)
                        fourthDayDayForecast.append(info)
                        
                        fourthDayTemp = ForecastWeatherList(weekDay: weekday, hourlyForecast: fourthDayDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 4){
                        let info = WeatherInfo(temp: temperature, humidity: humidity, description: descriptionTemp, time: time, id: id, icon: icon)
                        fifthDayForecast.append(info)
                        fifthDayTemp = ForecastWeatherList(weekDay: weekday, hourlyForecast: fifthDayForecast)
                        fetchedData.append(info)
                        
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 5) {
                        let info = WeatherInfo(temp: temperature, humidity: humidity, description: descriptionTemp, time: time, id: id, icon: icon)
                        sixthDayForecast.append(info)
                        sixthDayTemp = ForecastWeatherList(weekDay: weekday, hourlyForecast: sixthDayForecast)
                        fetchedData.append(info)
                        
                    }

                    
                    if fetchedData.count == totalData {
                        
                        if currentDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(currentDayTemp)
                        }
                        
                        if secondDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(secondDayTemp)
                        }
                        
                        if thirdDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(thirdDayTemp)
                        }
                        
                        if fourthDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(fourthDayTemp)
                        }
                        
                        if fifthDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(fifthDayTemp)
                        }
                        
                        if sixthDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(sixthDayTemp)
                        }
                        
                        
                        if forecastmodelArray.count <= 6 {
                            completion(.Success(forecastmodelArray))
                        }
                    }
                    
                }
                
                completion(.Success(forecastmodelArray))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    
    }
}
