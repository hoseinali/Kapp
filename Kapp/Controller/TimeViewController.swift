//
//  TimeViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/8/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController, DateTimePickerDelegate {

    var datePicker: DateTimePicker?
    var timePicker: DateTimePicker?
    var isTime: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func showDatePicker(sender: AnyObject) {
        isTime = false
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 7)
        let datePicker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        datePicker.timeInterval = DateTimePicker.MinuteInterval.thirty
        datePicker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        datePicker.darkColor = UIColor.darkGray
        datePicker.doneButtonTitle = "ثبت تاریخ"
        datePicker.doneBackgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
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
            self.title = formatter.string(from: date)
        }
        datePicker.delegate = self
        self.datePicker = datePicker
    }
    
    @IBAction func showTimePicker(sender: AnyObject) {
        isTime = true
        let min = Date()
        let calendar = Calendar.current
        let max = calendar.date(byAdding: .minute, value: 60, to: min)
        let timePicker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        timePicker.timeInterval = DateTimePicker.MinuteInterval.thirty
        timePicker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        timePicker.darkColor = UIColor.darkGray
        timePicker.doneButtonTitle = "ثبت تاریخ"
        timePicker.doneBackgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
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
            formatter.dateFormat = "YYYY/MM/dd"
            self.title = formatter.string(from: date)
        }
        timePicker.delegate = self
        self.timePicker = timePicker
    }
    
    // Method
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.calendar = Calendar.init(identifier: .persian)
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let _ = dateFormatter.string(from: didSelectDate)
        print(picker.selectedDateString)
    }
    
    func updateUI() {
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 40)!], for: .normal)
        let backButton = UIBarButtonItem(title: "بازگشت", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 16)!], for: .normal)
        navigationItem.backBarButtonItem = backButton
        self.navigationItem.title = "انتخاب زمان"
    }
    
    
}
