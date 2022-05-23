//
//  String+Extension.swift
//  Weathery
//
//  Created by TheGIZzz on 23/5/2565 BE.
//

import Foundation

extension String {
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}
