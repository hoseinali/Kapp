//
//  Constants.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// COMPLETION HANDLERS
typealias COMPLETION_SUCCESS = (_ Success:Bool) -> ()
typealias FORMDATA_PARAMETER = [String:String]

// URL
let BASE_URL = "https://samcarcare.ir/ic-app/"
let LOGIN_GET_CODE_URL = "\(BASE_URL)api-users.php?do=login&lvl=getcode"
let LOGIN_GET_ACCESS_URL = "\(BASE_URL)api-users.php?do=login&lvl=getaccess"
let REGISTER_S1_URL = "\(BASE_URL)api-users.php?do=register_s1"
let OKCODE_USER_URL = "\(BASE_URL)api-users.php?do=register_s2&mobile="
let RESEND_CODE_URL = "\(BASE_URL)api-users.php?do=reokcode&mobile="
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
let REGISTER_KEY = "registerKey"

// HEADERS
let DEFAULT_HEADER = ["Content-Type": "application/json; charset=utf-8"]

// SEGUE
let NO_SEGUE = ""
let MAIN_SEGUE = "mainViewControllerSegue"
let SPEND_SEGUE = "SpendViewControllerSegue"
let SIDE_SEGUE = "containSideMenuSegue"
let PROFILE_SEGUE = "profileTableViewControllerSegue"
let CUSTOM_SEGUE = "cutstomViewControllerSegue"
let BAG_RESULT_SEGUE = "BagResultViewControllerSegue"
let CREDIT_SEGUE = "CreditViewControllerSegue"
let CALL_US_SEGUE = "CallUsViewControllerSegue"
let CONFIRM_SEGUE = "ConfirmViewControllerSegue"
let CAR_CHOSEN_SEGUE = "CarChosenViewControllerSegue"
let ORDER_DETAIL_LIST_SEGUE = "OrderDetailViewControllerSegue"
let CAR_SERVICE_SEGUE = "CarServiceViewControllerSegue"
let TIME_SEGUE = "TimeViewControllerSegue"
let REGISTER_ORDER_SEGUE = "RegisterOrderViewControllerSegue"

// UNWIND SEGUE
let UNWIND_MAIN_SEGUE = "unwindToMainViewControllerSegue"

// STORYBOARD ID
let REGISTER_VC_ID = "RegisterViewControllerID"
let INTERNET_VC_ID = "InternetConnectionViewControllerID"

// FONT
let YEKAN_WEB_FONT = "WeblogmaYekan"

// GOOGLE API KEY
let GOOGLE_API_KEY = "AIzaSyAlwlQGZlbb18ZN6r8o8idtheZZYBEqzoA"

// CELL IDENTIFIER
let SPEND_CELL = "spendCell"
let BAG_RESULT_CELL = "bagResultCell"
let ORDER_DETAIL_CELL = "orderDetailCell"
let CHOSEN_SERVICE_CELL = "ChosenServiceCell"
let CAR_SERVICE_COLLECTION_CELL = "CarServiceCollectionCell"
let CAR_SERVICE_TABLE_CELL = "CarServiceTableCell"

// NOTIFICATION
let DISMISS_ROOT_INDICATOR_NOTIFI = Notification.Name("dismissRootActivityIndicator")
let DISMISS_INDICATOR_VC_NOTIFI = Notification.Name("dismissIndicatorVCActivityIndicator")








