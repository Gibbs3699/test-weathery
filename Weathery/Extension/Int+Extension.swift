//
//  Int+Extension.swift
//  Weathery
//
//  Created by TheGIZzz on 23/5/2565 BE.
//

import Foundation

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}
