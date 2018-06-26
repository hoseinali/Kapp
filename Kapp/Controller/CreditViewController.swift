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

    // Outlet
    @IBOutlet weak var mounthTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        mounthTextField.resignFirstResponder()
        guard let mount = mounthTextField.text else { return }
        guard !mount.isEmpty && Int(mount)! >= 10000 else {
            let message = "مبلغ مورد تایید نیست، حداقل مبلغ شارژ کیف پول ده هزار تومان میباشد !"
            Utilities.instance.presentWarningAlert(message: message)
            return
        }
        let message = "آیا مبلغ \(mount) تومان مورد تایید است ؟"
        presentAgreeAlert(message: message)
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

    func presentAgreeAlert(message: String) {
        let alert = CDAlertView(title: "توجه !", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let done = CDAlertViewAction(title: "بله", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.mounthTextField.resignFirstResponder()
            return true
        }
        let cancel = CDAlertViewAction(title: "خیر", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: done)
        alert.add(action: cancel)
        alert.show()
    }
    
    
}
