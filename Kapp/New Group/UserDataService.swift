//
//  UserDataService.swift
//  Kapp
//
//  Created by hosein on 6/19/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class UserDataService {
    
    static let instance = UserDataService()
    
    let defaults = UserDefaults.standard
    
    var isLogin: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    public private(set) var phoneNumber: String {
        get {
            return defaults.value(forKey: PHONE_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: PHONE_KEY)
        }
    }
    
    public private(set) var uid: String {
        get {
            return defaults.value(forKey: UID_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: UID_KEY)
            
        }
    }
    
    public private(set) var ssid: String {
        get {
            return defaults.value(forKey: SSID_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: SSID_KEY)
        }
    }
    
    var mount: Int {
        get {
            return defaults.integer(forKey: CASH_KEY)
        }
        set {
            defaults.set(newValue, forKey: CASH_KEY)
        }
    }
    
    var cash: Int {
        get {
            return defaults.integer(forKey: CASH_KEY)
        }
        set {
            defaults.set(newValue, forKey: CASH_KEY)
        }
    }
    
    func setUserData(uid: String, ssid: String, isLogin: Bool, phoneNumber: String) {
        self.uid = uid
        self.ssid = ssid
        self.isLogin = isLogin
        self.phoneNumber = phoneNumber
    }
    
    func logoutProfile() {
        UserDataService.instance.setUserData(uid: "", ssid: "", isLogin: false, phoneNumber: "")
        self.cash = 0
        self.mount = 0
        UserDefaults.standard.set(false, forKey: REGISTER_KEY)
        let image = UIImage(named: "profileDefault")!
        if let media = Media(withImage: image, forKey: "") {
            Media.encode(save: media, directory: Media.archiveURL) // save^
        }
    }
    
    
}
