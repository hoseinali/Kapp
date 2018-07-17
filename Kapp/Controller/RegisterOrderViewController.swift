//
//  RegisterOrderViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/8/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import CDAlertView

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
        startIndicatorAnimate()
        OrderService.instance.registerOrder(orderType: .byCredit) { (success) in
            if success {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    let message = "سفارش شما با متود کسر از اعتبار با موفقیت ثبت شد !"
                    self.presentAlert(message: message)
                }
            } else {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    let message = "خطا در ثبت سفارش رخ داده است، لطفا مجددا تلاش کنید !"
                    self.presentWarningAlert(message: message)
                }
            }
        }
    }
    
    @IBAction func deliveryPaymentButtonPressed(_ sender: RoundedButton) {
        view.endEditing(true)
        guard SettingService.instance.orderStatus else {
            let message = "امکان ثبت سفارش برای شما امکانپذیر نیست ! با پشتیبان سایت تماس حاصل فرمایید."
            self.presentWarningAlert(message: message)
            return
        }
        startIndicatorAnimate()
        OrderService.instance.registerOrder(orderType: .byCredit) { (success) in
            if success {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    let message = "سفارش شما با متود پرداخت در محل با موفقیت ثبت شد !"
                    self.presentAlert(message: message)
                }
            } else {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    let message = "خطا در ثبت سفارش رخ داده است، لطفا مجددا تلاش کنید !"
                    self.presentWarningAlert(message: message)
                }
            }
        }
    }
    
    /*
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
    */
 
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
        let orderTime = UserOrderService.instance.orderTime!
        let timeText = "\(orderTime) الی \(Int(orderTime)! + 1)"
        self.timeLabel.text = timeText
        self.dateLabel.text = UserOrderService.instance.orderDate
        let productName = UserOrderService.instance.products!.map { $0.title }.joined(separator: " , ")
        self.productNameLabel.text = productName
        self.totalPriceLabel.text = UserOrderService.instance.totalPrice?.seperateByCama
    }
    
    func presentAlert(message: String) {
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let done = CDAlertViewAction(title: "باشه", font: UIFont(name: YEKAN_WEB_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.performSegue(withIdentifier: UNWIND_MAIN_SEGUE, sender: nil)
            
            return true
        }
        alert.add(action: done)
        alert.show()
    }
    

}
