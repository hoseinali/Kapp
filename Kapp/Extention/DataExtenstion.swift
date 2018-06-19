//
//  DataExtenstion.swift
//  Kapp
//
//  Created by hosein on 6/19/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
