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
let USER_INFO_URL = "\(BASE_URL)api-users.php?do=user_info"
let UPDATE_USER_INFO_URL = "\(BASE_URL)api-users.php?do=profile_up"
let SEND_PM_URL = "\(BASE_URL)api-users.php?do=pm"
let CASH_GET_URL = "\(BASE_URL)api-pay.php?do=cashget"
let PAY_LIST_URL = "\(BASE_URL)api-pay.php?do=paylist"
let CASH_LOG_URL = "\(BASE_URL)api-pay.php?do=cashlog"
let BANK_CASH_URL = "\(BASE_URL)api-pay.php?do=pay"
let ORDER_LIST_URL = "\(BASE_URL)api-order.php?do=orderlist"
let COPON_CHECK_URL = "\(BASE_URL)api-order.php?do=coponcheck"


// DEFAULT USERS
let PHONE_KEY = "phone"
let UID_KEY = "uid"
let SSID_KEY = "ssid"
let LOGGED_IN_KEY = "loggedIn"
let CASH_KEY = "cashKey"


// HEADERS
let DEFAULT_HEADER = ["Content-Type": "application/json; charset=utf-8"]
