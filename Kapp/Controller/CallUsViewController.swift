//
//  CallUsViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController
import UICheckbox_Swift
import SBCardPopup

class CallUsViewController: UIViewController, SideMenuControllerDelegate {
    
    // Outlet
    @IBOutlet weak var observeTextField: UITextField!
    @IBOutlet weak var titleObserveTextField: UITextField!
    @IBOutlet weak var rumbleCheckBox: UICheckbox!
    @IBOutlet weak var pmCheckBox: UICheckbox!
    @IBOutlet weak var observeCheckBox: UICheckbox!
    
    var pretitle: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        guard let title = titleObserveTextField.text, title != "" else {
            let message = "لطفا متن نظر خود را وارد کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        guard let content = observeTextField.text, content != "" else {
            let message = "لطفا موضوع نظر خود را وارد کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        guard let preTitle = pretitle else {
            let message = "لطفا نوع پیام را مشخص کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        self.view.endEditing(true)
        startIndicatorAnimate()
        PersonalInfromationService.instance.sendPmUser(title: title, content: content, pretitle: preTitle) { (success, message) in
            if success {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    self.observeTextField.text = ""
                    self.titleObserveTextField.text = ""
                    self.pretitle = nil
                    self.presentWarningAlert(message: message)
                }
            } else {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    self.presentWarningAlert(message: message)
                }
            }
        }
    }
    
    // Oject
    @objc func closeTouchPressed() {
        view.endEditing(true)
    }

    // Method
    func updateUI() {
        sideMenuController?.delegate = self
        view.bindToKeyboard()
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTouchPressed))
        view.addGestureRecognizer(closeTouch)
        checkBoxAction()
    }
    
    func checkBoxAction() {
        rumbleCheckBoxAction()
        pmCheckBoxAction()
        observeCheckBoxAction()
    }
    
    func observeCheckBoxAction() {
        observeCheckBox.onSelectStateChanged = { (checkbox, selected) in
            debugPrint("Clicked - observe")
            if selected {
                self.rumbleCheckBox.isSelected = false
                self.pmCheckBox.isSelected = false
                self.pretitle = 3
            }
        }
    }
    
    func pmCheckBoxAction() {
        pmCheckBox.onSelectStateChanged = { (checkbox, selected) in
            if selected {
                debugPrint("Clicked - pm")
                self.observeCheckBox.isSelected = false
                self.rumbleCheckBox.isSelected = false
                self.pretitle = 2
            }
        }
    }
    
    func rumbleCheckBoxAction() {
        rumbleCheckBox.onSelectStateChanged = { (checkbox, selected) in
            if selected {
                debugPrint("Clicked - rumble")
                self.pmCheckBox.isSelected = false
                self.observeCheckBox.isSelected = false
                self.pretitle = 1
            }
        }
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    

}
