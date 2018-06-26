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

    // Action
    @IBAction func resendButtonPressed(_ sender: UIButton) {
        resetTimer()
    }
    
    @IBAction func confirmButtonPressed(_ sender: RoundedButton) {
        UserDefaults.standard.set(true, forKey: REGISTER_KEY)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func wrongNumberButtonPressed(_ sender: UIButton) {
        resetTimer()
        dismiss(animated: true, completion: nil)
    }
    
    // Method
    func updateUI() {
        self.resendButton.isEnabled = false
        startTimer()
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
