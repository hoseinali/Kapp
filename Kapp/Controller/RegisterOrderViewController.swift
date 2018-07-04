//
//  RegisterOrderViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/8/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class RegisterOrderViewController: UIViewController {

    // Outlet
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var factorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func creditPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: sender)
    }
    
    @IBAction func deliveryPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: sender)
    }
    
    @IBAction func bankPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: sender)
    }
    
    // Objc
    @objc func closeTouch() {
        view.endEditing(true)
    }
    
    // Method
    func updateUI() {
        let touchTap = UITapGestureRecognizer(target: self, action: #selector(closeTouch))
        factorView.addGestureRecognizer(touchTap)
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        backgroundImageView.addSubview(blurEffectView)
        self.navigationItem.title = "ثبت سفارش"
    }
    
    
}
