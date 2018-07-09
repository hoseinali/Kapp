//
//  CreditViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController
import CDAlertView

class CreditViewController: UIViewController, SideMenuControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        let ssid = UserDataService.instance.ssid
        let uid = UserDataService.instance.uid
        let url = URL.init(string: "&uid=\(uid)&ssid=\(ssid)")
        if let url = url {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    // Method
    func updateUI() {
        sideMenuController?.delegate = self
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }

    
}
