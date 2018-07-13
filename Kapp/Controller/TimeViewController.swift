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
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var datePicker: DateTimePicker?
    
    var isTodayOrder: Bool = true {
        didSet {
            orderTime = nil
            timeLabel.text = "انتخاب زمان"
            timeButton.setTitle("ساعت سفارش معین نشده است", for: .normal)
            self.pickerView.reloadAllComponents()
        }
    }
    
    var orderDate: String?
    var orderTime: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Objc
    @objc func closeTouch() {
        removeTimeViewAnimate()
    }
    
    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        removeTimeViewAnimate()
        guard let _ = orderTime, let _ = orderDate else {
            let message = "هر دو مورد روز سفارش و زمان سفارش را انتخاب کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        UserOrderService.instance.orderTime = orderTime
        UserOrderService.instance.orderDate = orderDate
        performSegue(withIdentifier: REGISTER_ORDER_SEGUE, sender: sender)
    }
    
    @IBAction func showDatePicker(sender: AnyObject) {
        removeTimeViewAnimate()
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
        datePicker.includeMonth = false
        datePicker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.calendar = Calendar.init(identifier: .persian)
            formatter.locale = Locale(identifier: "en")
            formatter.dateFormat = "yyyy/MM/dd"
            let dayDate = formatter.string(from: date)
            self.orderDate = dayDate
            if self.orderDate == Date().PersianDate() {
                self.isTodayOrder = true
            } else {
                self.isTodayOrder = false
            }
            self.dateButton.setTitle("روز سفارش : \(dayDate)", for: .normal)
        }
        self.datePicker = datePicker
        self.datePicker!.delegate = self
    }
    
    @IBAction func showTimePicker(sender: AnyObject) {
        guard orderDate != nil else {
            let message = "لطفا ابتدا تاریخ را معین کنید !"
            presentWarningAlert(message: message)
            return
        }
        showTimeViewAnimate()
        guard orderTime != nil else {
            timeLabel.text = "انتخاب زمان"
            return
        }
        let time = "\(Int(orderTime!)!) الی \(Int(orderTime!)! + 1)"
        timeLabel.text = time
    }
    
    // Action - TimePicker
    @IBAction func saveTimeButtonPressed(sender: UIButton) {
        switch isTodayOrder {
        case true:
            guard SettingService.instance.todayOpenTime.count > 0 else { return }
            guard orderTime != nil else {
                orderTime = String(SettingService.instance.todayOpenTime[0])
                let time = "\(Int(orderTime!)!) الی \(Int(orderTime!)! + 1)"
                timeButton.setTitle(time, for: .normal)
                removeTimeViewAnimate()
                return
            }
            // if not nil, time befor *
        default:
            guard orderTime != nil else {
                orderTime = String(SettingService.instance.weekOpenTime[0])
                let time = "\(Int(orderTime!)!) الی \(Int(orderTime!)! + 1)"
                timeButton.setTitle(time, for: .normal)
                removeTimeViewAnimate()
                return
            }
            // if not nil, time befor *
        }
        let time = "\(Int(orderTime!)!) الی \(Int(orderTime!)! + 1)"
        timeButton.setTitle(time, for: .normal)
        removeTimeViewAnimate()
    }
    
    @IBAction func closeTimeButtonPressed(sender: UIButton) {
        removeTimeViewAnimate()
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
        let translateTimeView = CGAffineTransform(translationX: 0, y: timeView.layer.bounds.height)
        timeView.transform = translateTimeView
        let close = UITapGestureRecognizer(target: self, action: #selector(closeTouch))
        view.addGestureRecognizer(close)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func showTimeViewAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.timeView.transform = CGAffineTransform.identity
        }) { (_) in
            //
        }
    }
    
    func removeTimeViewAnimate() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            let translateTimeView = CGAffineTransform(translationX: 0, y: self.timeView.layer.bounds.height)
            self.timeView.transform = translateTimeView
        }) { (_) in
            //
        }
    }
    
    
}


extension TimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isTodayOrder {
            return SettingService.instance.todayOpenTime.count
        } else {
            return SettingService.instance.weekOpenTime.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isTodayOrder {
            guard SettingService.instance.todayOpenTime.count > 0 else { return }
            orderTime = String(SettingService.instance.todayOpenTime[row])
            let time = "\(Int(orderTime!)!) الی \(Int(orderTime!)! + 1)"
            timeLabel.text = time
        } else {
            guard SettingService.instance.weekOpenTime.count > 0 else { return }
            orderTime = String(SettingService.instance.weekOpenTime[row])
            let time = "\(Int(orderTime!)!) الی \(Int(orderTime!)! + 1)"
            timeLabel.text = time
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: YEKAN_WEB_FONT, size: 17)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.textColor = UIColor.darkGray
        var text = ""
        if isTodayOrder {
            let time = SettingService.instance.todayOpenTime[row]
            text = "\(time) الی \(time + 1)"
            pickerLabel?.text = text
        } else {
            let time = SettingService.instance.weekOpenTime[row]
            text = "\(time) الی \(time + 1)"
            pickerLabel?.text = text
        }
        
        return pickerLabel!
    }
    
    
}
