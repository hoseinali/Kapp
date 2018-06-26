//
//  Utilities.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/6/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation
import CDAlertView

class Utilities {
    
    static let instance = Utilities()
    
    func presentWarningAlert(message: String) {
        let alert = CDAlertView(title: "توجه !", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let cancel = CDAlertViewAction(title: "باشه", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: cancel)
        alert.show()
    }
    
    
}
