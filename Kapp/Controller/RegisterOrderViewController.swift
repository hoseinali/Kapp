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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coponTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Objc
    @objc func closeTouch() {
        view.endEditing(true)
    }
    
    // Action
    @IBAction func coponCheckButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        guard let copon = coponTextField.text else { return }
        guard !copon.isEmpty else {
            let message = "لطفا کوپن را وارد کنید !"
            presentWarningAlert(message: message)
            return
        }
        startIndicatorAnimate()
        OrderService.instance.CoponCheck(copon: copon) { (success) in
            if success {
                guard let copon = OrderService.instance.copon else { return }
                let coponPrice = copon.price!
                let coponId = copon.id!
                UserOrderService.instance.coponPrice = coponPrice
                UserOrderService.instance.coponPrice = coponPrice
                UserOrderService.instance.coponId = coponId
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    self.coponTextField.text = "مبلغ \(coponPrice.seperateByCama) کوپن ثبت شد"
                    let message = "کوپن شما به مبلغ \(coponPrice.seperateByCama) ریـال با موفقیت ثبت شد !"
                    self.presentWarningAlert(message: message)
                }
            } else {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    self.coponTextField.text = ""
                    let message = "کوپن وارد شده صحیح نمیباشد !"
                    self.presentWarningAlert(message: message)
                }
            }
        }
    }
    
    @IBAction func creditPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        guard SettingService.instance.orderStatus else {
            let message = "امکان ثبت سفارش برای شما امکانپذیر نیست ! با پشتیبان سایت تماس حاصل فرمایید."
            self.presentWarningAlert(message: message)
            return
        }
        // if success clear userOrderService *
        performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: sender)
    }
    
    @IBAction func deliveryPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        guard SettingService.instance.orderStatus else {
            let message = "امکان ثبت سفارش برای شما امکانپذیر نیست ! با پشتیبان سایت تماس حاصل فرمایید."
            self.presentWarningAlert(message: message)
            return
        }
        // if success clear userOrderService *
        performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: sender)
    }
    
    @IBAction func bankPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        guard SettingService.instance.orderStatus else {
            let message = "امکان ثبت سفارش برای شما امکانپذیر نیست ! با پشتیبان سایت تماس حاصل فرمایید."
            self.presentWarningAlert(message: message)
            return
        }
        // if success clear userOrderService *
        performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: sender)
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
        updateOrderLabel()
        print("ordertime: \(UserOrderService.instance.orderTime!)\norderDate: \(UserOrderService.instance.orderDate!)\n")
    }
    
    func updateOrderLabel() {
        self.timeLabel.text = UserOrderService.instance.orderTime
        self.dateLabel.text = UserOrderService.instance.orderDate
    }
    
}
