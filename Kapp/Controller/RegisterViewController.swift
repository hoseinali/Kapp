//
//  RegisterViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // Outlet
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var refTextField: UITextField!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    let slideDownTransition = SlideDownTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    // Action
    @IBAction func RegisterButtonPressed(_ sender: RoundedButton) {
        guard let phoneNumber = phoneTextField.text, let refNumber = refTextField.text else { return }
        guard phoneNumberCondition(phoneNumber: phoneNumber)  else {
            return
        }
        view.endEditing(true)
        startIndicatorAnimate()
        AuthenticationService.instance.registerGetCode(number: phoneNumber, refMobileNumber: refNumber) { (success) in
            if success {
                print("success register user for first time !")
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: CONFIRM_SEGUE, sender: nil)
                }
            } else {
                print("register new user failed !")
                AuthenticationService.instance.loginGetCode(number: phoneNumber, completion: { (success) in
                    if success {
                        print("success login old user !")
                        self.stopIndicatorAnimate()
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: CONFIRM_SEGUE, sender: nil)
                        }
                    } else {
                        print("failed login old user !")
                        self.stopIndicatorAnimate()
                        let message = "ورود با مشکل مواجه شده است لطفا مجددا تلاش کنید !"
                        DispatchQueue.main.async {
                            self.presentWarningAlert(message: message)
                        }
                    }
                })
            }
        }
    }
    
    // Method
    func updateUI() {
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .asciiCapableNumberPad
        refTextField.keyboardType = .asciiCapableNumberPad
    }
    
    func phoneNumberCondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
            let message = "شماره همراه خالی میباشد !"
            presentWarningAlert(message: message)
            return false
        }
        let startIndex = number.startIndex
        let zero = number[startIndex]
        guard zero == "0" else {
            let message = "شماره همراه خود را با صفر وارد کنید !"
            presentWarningAlert(message: message)
            return false
        }
        guard number.count == 11 else {
            let message = "شماره همراه میبایست یازده رقمی باشد !"
            presentWarningAlert(message: message)
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination
        toViewController.transitioningDelegate = slideDownTransition
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
    
    
    
}
