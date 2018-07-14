//
//  DateExtention.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/17/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

extension Date {
    
    func PersianDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.init(identifier: .persian)
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: self)
    }
    
    func hourNow() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let dateAsString = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: dateAsString)!
        dateFormatter.dateFormat = "HH"
        
        return Int(dateFormatter.string(from: date))!
    }
    
    func minuteInHourNow() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let dateAsString = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: dateAsString)!
        dateFormatter.dateFormat = "mm"
        
        return Int(dateFormatter.string(from: date))!
    }
    
}
