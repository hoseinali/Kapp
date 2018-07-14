//
//  SettingService.swift
//  Kapp
//
//  Created by hosein on 7/10/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SettingService {
    
    static let instance = SettingService()
    
    var setting: Setting!
    
    func fetechStteings(completion:@escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = CONTROLL_SERVICE_URL + "&uid=\(uid)&ssid=\(ssid)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { completion(false) ; return }
                guard let json = try? JSON.init(data: data) else { completion(false) ; return }
                guard let Services = json["data"].array else { completion(false) ; return }
                guard let SYS_STATUS = Services[0].array else { completion(false) ; return }
                let SYS_STATUS_VALUE = SYS_STATUS[0].stringValue
                guard let SYS_STATUS_PM = Services[1].array else { completion(false) ; return }
                let SYS_STATUS_PM_FA = SYS_STATUS_PM[2].stringValue
                guard let ORDER_STATUS = Services[2].array else { completion(false) ; return }
                let ORDER_STATUS_VALUE = ORDER_STATUS[0].stringValue
                guard let AM_START = Services[3].array else { completion(false) ; return }
                let AM_START_VALUE = AM_START[0].stringValue
                guard let AM_STOP = Services[4].array else { completion(false) ; return }
                let AM_STOP_VALUE = AM_STOP[0].stringValue
                guard let PM_START = Services[5].array else { completion(false) ; return }
                let PM_START_VALUE = PM_START[0].stringValue
                guard let PM_STOP = Services[6].array else { completion(false) ; return }
                let PM_STOP_VALUE = PM_STOP[0].stringValue
                let setting = Setting.init(SYS_STATUS: SYS_STATUS_VALUE, SYS_STATUS_PM: SYS_STATUS_PM_FA, ORDER_STATUS: ORDER_STATUS_VALUE, AM_START: AM_START_VALUE, AM_STOP: AM_STOP_VALUE, PM_START: PM_START_VALUE, PM_STOP: PM_STOP_VALUE)
                self.setting = setting
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    var systemStatus: Bool {
        // در صورت منفی بودن کاربر هیچ فعالیتی را نتواند انجام دهد
        if setting.SYS_STATUS == "1" {
            return false
        }
        return true
    }
    
    var systemStatusPM: String {
        // اگر منفی بود وضعیت کل سیستم بسته نمایش داده شود
        return setting.SYS_STATUS_PM
    }
    
    var orderStatus: Bool {
        // در صورتی که منفی بود کاربر از برنامه استفاده کند اما نتواند سفارشی ثبت کند
        if setting?.ORDER_STATUS == "1" {
            return false
        }
        return true
    }
    
    var todayOpenTime: [Int] {
        var times = [Int]()
        let amStart = Int(setting.AM_START)!
        let amStop = Int(setting.AM_STOP)!
        let pmStart = Int(setting.PM_START)!
        let pmStop = Int(setting.PM_STOP)!
        for number in amStart..<amStop {
            times.append(number)
        }
        for number in pmStart..<pmStop {
            times.append(number)
        }
        var openTime = [Int]()
        let hour = Date().hourNow()
        let minute = Date().minuteInHourNow()
        for time in times {
            let intTime = time
            if intTime >= hour {
                openTime.append(intTime)
            }
        }
        for (index,time) in openTime.enumerated() {
            if time == hour {
                if minute >= 30 {
                    print("time is \(time) index \(index)")
                    openTime.remove(at: index)
                }
            }
        }
        
        return openTime
    }
    
    var weekOpenTime: [Int] {
        var times = [Int]()
        let amStart = Int(setting.AM_START)!
        let amStop = Int(setting.AM_STOP)!
        let pmStart = Int(setting.PM_START)!
        let pmStop = Int(setting.PM_STOP)!
        for number in amStart..<amStop {
            times.append(number)
        }
        for number in pmStart..<pmStop {
            times.append(number)
        }
        
        return times
    }
    

}
