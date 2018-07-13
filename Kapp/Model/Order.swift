//
//  Order.swift
//  Kapp
//
//  Created by hosein on 7/6/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Order {
    
    var orderName: String
    let cart: String
    let send_time: String
    let send_day: Int
    let copon: Int
    let price: Int
    let pay_method: Int
    let pay_id: Int
    let uid: Int
    let address: String
    let formatted_address: String
    let lat: String
    let lng: String
    let comment: String
    let upm: String
    let date: String
    let time: String
    let status: String
    
}

enum OrderType {
    case byCredit, byBank, cashOnDelivery
}
