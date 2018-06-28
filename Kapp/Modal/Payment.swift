//
//  Payment.swift
//  Kapp
//
//  Created by hosein on 6/28/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Payment {
    
    var money: Int
    
    public enum ChoosenMoney: String {
        case null = "هیچکدام"
        case twenty = "بیست هزار تومان"
        case fifty = "پنحاه هزار تومان"
        case hundred = "صـد هزار تومان"
    }
    
    public enum PayMethod {
        case byCredit
        case byBankCard
        case cashOnDelivery
    }
    
}

