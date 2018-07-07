//
//  ConfirmViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }

    // Action
    @IBAction func resendButtonPressed(_ sender: UIButton) {
        startIndicatorAnimate()
        AuthenticationService.instance.reOkCode(number: AuthenticationService.instance.phoneNumber) { (success) in
            if success {
                print("success resend code to phone \(AuthenticationService.instance.phoneNumber)")
                self.stopIndicatorAnimate()
                self.resetTimer()
                self.startTimer()
                DispatchQueue.main.async {
                    let message = "کد تایید مجددا ارسال شد !"
                    self.presentWarningAlert(message: message)
                }
            } else {
                self.stopIndicatorAnimate()
                print("failed resend code to \(AuthenticationService.instance.phoneNumber)")
                DispatchQueue.main.async {
                    let message = "خطا در ارسال کد لطفا مجددا تلاش کنید !"
                    self.presentWarningAlert(message: message)
                }
            }
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: RoundedButton) {
        UserDefaults.standard.set(true, forKey: REGISTER_KEY)
        guard let code = codeTextField.text, code != "" else {
            presentWarningAlert(message: "کد تایید را وارد کنید !")
            return
        }
        startIndicatorAnimate()
        if AuthenticationService.instance.isOldUser {
            AuthenticationService.instance.loginGetAccess(okCode: code, number: AuthenticationService.instance.phoneNumber) { (success) in
                if success {
                    self.stopIndicatorAnimate()
                    DispatchQueue.main.async {
                        print("success old user login code with ssid: \(UserDataService.instance.ssid)")
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("failed old user login code")
                    self.stopIndicatorAnimate()
                    DispatchQueue.main.async {
                        let message = "ورود با مشکل واجه شده است لطفا مجددا تلاش کنید !"
                        self.presentWarningAlert(message: message)
                    }
                }
            }
        } else {
            AuthenticationService.instance.registerGetAccess(okCode: code, number: AuthenticationService.instance.phoneNumber) { (success) in
                if success {
                    self.stopIndicatorAnimate()
                    DispatchQueue.main.async {
                        print("success new user login code with ssid: \(UserDataService.instance.ssid)")
                        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("failed new user login code")
                    self.stopIndicatorAnimate()
                    DispatchQueue.main.async {
                        let message = "ورود با مشکل واجه شده است لطفا مجددا تلاش کنید !"
                        self.presentWarningAlert(message: message)
                    }
                }
            }
        }
    }
    
    @IBAction func wrongNumberButtonPressed(_ sender: UIButton) {
        resetTimer()
        dismiss(animated: true, completion: nil)
    }
    
    // Method
    func updateUI() {
        self.resendButton.isEnabled = false
        codeTextField.keyboardType = .asciiCapableNumberPad
    }
    
    func codeCondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
            // warning *
            return false
        }
        
        return true
    }
    
    // MARK - Timer count down
    private var timer: Timer?
    private var elapsedTimeInSecond: Int = 60
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.elapsedTimeInSecond -= 1
            self.updateTimeLabel()
            if self.elapsedTimeInSecond == 0 {
                self.pauseTimer()
                self.resendButton.isEnabled = true
            }
        })
    }
    
    private func resetTimer() {
        self.resendButton.isEnabled = false
        timer?.invalidate()
        elapsedTimeInSecond = 60
        updateTimeLabel()
    }
    
    private func pauseTimer() {
        timer?.invalidate()
    }
    
    private func updateTimeLabel() {
        let seconds = elapsedTimeInSecond % 60
        let text = String(format: "%02d",seconds)
        timeLabel.text = text
    }
    
    
}
