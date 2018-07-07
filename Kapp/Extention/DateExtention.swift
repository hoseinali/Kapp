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
    
}
