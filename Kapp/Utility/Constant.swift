//
//  Constant.swift
//  Kapp
//
//  Created by hosein on 6/19/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation


// COMPLETION HANDLERS
typealias COMPLETION_SUCCESS = (_ Success:Bool) -> ()
typealias FORMDATA_PARAMETER = [String:String]

// URL
let BASE_URL = "https://samcarcare.ir/ic-app/"
let LOGIN_GET_CODE = "\(BASE_URL)api-users.php?do=login&lvl=getcode"
let LOGIN_GET_ACCESS = "\(BASE_URL)api-users.php?do=login&lvl=getaccess"
let REGISTER_S1_URL = "\(BASE_URL)api-users.php?do=register_s1"
let OKCODE_USER_URL = "\(BASE_URL)api-users.php?do=register_s2"
let RESEND_CODE_URL = "\(BASE_URL)api-users.php?do=reokcode"
let USER_INFO_URL = "\(BASE_URL)api-users.php?do=reokcode"
let UPDATE_USER_INFO_URL = "\(BASE_URL)api-users.php?do=profile_up"
let SEND_PM_URL = "\(BASE_URL)api-users.php?do=pm"

// DEFAULT USERS
let PHONE_KEY = "phone"
let UID_KEY = "uid"
let SSID_KEY = "ssid"
let LOGGED_IN_KEY = "loggedIn"

// HEADERS
let DEFAULT_HEADER = ["Content-Type": "application/json; charset=utf-8"]
