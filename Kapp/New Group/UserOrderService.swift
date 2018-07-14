//
//  UserOrderService.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/19/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

class UserOrderService {
    
    static let instance = UserOrderService()
    
    public var userLocation: (lat: String, long: String)?
    public var orderTime: String?
    public var orderDate: String?
    public var coponPrice: String?
    public var coponId: Int?
    public var totalPrice: Int?
    public var products: [Product]?
    public var address: String?
    
    func clearUserOrder() {
        userLocation = nil
        orderTime = nil
        orderDate = nil
        coponPrice = nil
        coponId = nil
        totalPrice = nil
        products = nil
        address = nil
    }
    

}
