//
//  InternetConnectionViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/6/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SBCardPopup

class InternetConnectionViewController: UIViewController, SBCardPopupContent {
    
    var popupViewController: SBCardPopupViewController?
    var allowsTapToDismissPopupCard: Bool = false
    var allowsSwipeToDismissPopupCard: Bool = false
    
    
    // Outlet

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        if WebService.instance.isConnectedToNetwork() {
            NotificationCenter.default.post(name: DISMISS_ROOT_INDICATOR_NOTIFI, object: nil)
            self.popupViewController?.close()
        }
    }
    
    // Method
    
    func updateUI() {
        //
    }
    
    static func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let internetConnectionPopup = storyboard.instantiateViewController(withIdentifier: INTERNET_VC_ID) as! InternetConnectionViewController
        return internetConnectionPopup
    }
    
    
}
