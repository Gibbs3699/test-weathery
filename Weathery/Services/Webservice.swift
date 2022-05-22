//
//  Webservice.swift
//  Weathery
//
//  Created by TheGIZzz on 21/5/2565 BE.
//

import Foundation
import Alamofire

enum NetworkResult<T> {
    case Success(T)
    case Error(Error)
}

class Webservice {
    
    static let shared = Webservice()
    
    func getCurrentWeather(city: String, completion: @escaping (NetworkResult<CurrentWeather>) -> Void) {
        
        guard let url = URL(string: APIClient.getCurrentWeather(city: city)) else { return }
        
        print("\n\n\(url)\n\n")
        
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
    
    
}
