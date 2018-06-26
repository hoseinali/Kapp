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

class CallUsViewController: UIViewController, SideMenuControllerDelegate {
    
    // Outlet
    @IBOutlet weak var observeTextField: UITextField!
    @IBOutlet weak var rumbleCheckBox: UICheckbox!
    @IBOutlet weak var pmCheckBox: UICheckbox!
    @IBOutlet weak var observeCheckBox: UICheckbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        guard let text = observeTextField.text, text != "" else {
            let message = "لطفا نظر خود را وارد کنید !"
            Utilities.instance.presentWarningAlert(message: message)
            return
        }
        view.endEditing(true)
        //
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
                //
            }
        }
    }
    
    func pmCheckBoxAction() {
        pmCheckBox.onSelectStateChanged = { (checkbox, selected) in
            if selected {
                debugPrint("Clicked - pm")
                self.observeCheckBox.isSelected = false
                self.rumbleCheckBox.isSelected = false
                //
            }
        }
    }
    
    func rumbleCheckBoxAction() {
        rumbleCheckBox.onSelectStateChanged = { (checkbox, selected) in
            if selected {
                debugPrint("Clicked - rumble")
                self.pmCheckBox.isSelected = false
                self.observeCheckBox.isSelected = false
                //
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
