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
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    let slideDownTransition = SlideDownTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    // Action
    @IBAction func RegisterButtonPressed(_ sender: RoundedButton) {
        performSegue(withIdentifier: CONFIRM_SEGUE, sender: nil)
    }
    
    // Method
    func updateUI() {
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .asciiCapableNumberPad
    }
    
    func phoneNumberCondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
            // warning *
            return false
        }
        let startIndex = number.startIndex
        let zero = number[startIndex]
        guard zero == "0" else {
            // warning *
            return false
        }
        guard number.count == 11 else {
            // warning *
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
