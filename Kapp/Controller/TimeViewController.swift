//
//  TimeViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/8/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController, DateTimePickerDelegate {
    
    // Outlet
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!

    var datePicker: DateTimePicker?
    var timePicker: DateTimePicker?
    
    var orderDate: String?
    var orderTime: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        guard let _ = orderTime, let _ = orderDate else {
            let message = "هر دو مورد روز سفارش و زمان سفارش را انتخاب کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        UserOrderService.instance.orderTime = orderTime
        UserOrderService.instance.orderDate = orderDate
        performSegue(withIdentifier: REGISTER_ORDER_SEGUE, sender: sender)
    }
    
    // Action
    @IBAction func showDatePicker(sender: AnyObject) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 7)
        let datePicker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        datePicker.timeInterval = DateTimePicker.MinuteInterval.thirty
        datePicker.highlightColor = #colorLiteral(red: 0.4979554415, green: 0.6144852042, blue: 0.812397182, alpha: 1)
        datePicker.darkColor = UIColor.darkGray
        datePicker.doneButtonTitle = "ثبت تاریخ"
        datePicker.doneBackgroundColor = #colorLiteral(red: 0.4979554415, green: 0.6144852042, blue: 0.812397182, alpha: 1)
        datePicker.locale = Locale(identifier: "en")
        datePicker.calendar = Calendar.init(identifier: .persian)
        datePicker.todayButtonTitle = "امروز"
        datePicker.is12HourFormat = true
        datePicker.dateFormat = "YYYY/MM/dd"
        datePicker.isDatePickerOnly = true
        datePicker.isTimePickerOnly = false
        datePicker.includeMonth = false // if true the month shows at top
        datePicker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.calendar = Calendar.init(identifier: .persian)
            formatter.locale = Locale(identifier: "en")
            formatter.dateFormat = "YYYY/MM/dd"
            let dayDate = formatter.string(from: date)
            self.orderDate = dayDate
            self.dateButton.setTitle("روز سفارش : \(dayDate)", for: .normal)
        }
        self.datePicker = datePicker
        self.datePicker!.delegate = self
    }
    
    @IBAction func showTimePicker(sender: AnyObject) {
        let min = Date()
        let calendar = Calendar.current
        let max = calendar.date(byAdding: .minute, value: 60, to: min)
        let timePicker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        timePicker.timeInterval = DateTimePicker.MinuteInterval.thirty
        timePicker.highlightColor = #colorLiteral(red: 0.4979554415, green: 0.6144852042, blue: 0.812397182, alpha: 1)
        timePicker.darkColor = UIColor.darkGray
        timePicker.doneButtonTitle = "ثبت تاریخ"
        timePicker.doneBackgroundColor = #colorLiteral(red: 0.4979554415, green: 0.6144852042, blue: 0.812397182, alpha: 1)
        timePicker.locale = Locale(identifier: "en")
        timePicker.calendar = Calendar.init(identifier: .persian)
        timePicker.todayButtonTitle = "امروز"
        timePicker.is12HourFormat = true
        timePicker.dateFormat = "hh:mm"
        timePicker.isDatePickerOnly = false
        timePicker.isTimePickerOnly = true
        timePicker.includeMonth = false // if true the month shows at top
        timePicker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.calendar = Calendar.init(identifier: .persian)
            formatter.locale = Locale(identifier: "en")
            formatter.dateFormat = "hh:mm"
            let timeDate = formatter.string(from: date)
            self.orderTime = timeDate
            self.timeButton.setTitle("ساعت سفارش : \(timeDate)", for: .normal)
            print(formatter.string(from: date))
        }
        self.timePicker = timePicker
        self.timePicker!.delegate = self
    }
    
    
    // Method
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        //
    }
    
    func updateUI() {
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        backgroundImageView.addSubview(blurEffectView)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 40)!], for: .normal)
        let backButton = UIBarButtonItem(title: "بازگشت", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 16)!], for: .normal)
        navigationItem.backBarButtonItem = backButton
        self.navigationItem.title = "انتخاب زمان"        
    }
    
    
    
}
